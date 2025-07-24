import psycopg2
from psycopg2 import sql
import sys
import json
from datetime import datetime
from tabulate import tabulate

# Database connection parameters
DB_PARAMS = {
    'host': 'db.bzlenegoilnswsbanxgb.supabase.co',
    'port': 5432,
    'database': 'postgres',
    'user': 'postgres',
    'password': 'GET@1a123'
}

class DatabaseManager:
    def __init__(self):
        self.conn = None
        self.cursor = None
        
    def connect(self):
        """Establish connection to the PostgreSQL database"""
        try:
            print("Connecting to PostgreSQL database...")
            self.conn = psycopg2.connect(**DB_PARAMS)
            self.conn.autocommit = True
            self.cursor = self.conn.cursor()
            
            # Test the connection
            self.cursor.execute("SELECT version();")
            db_version = self.cursor.fetchone()
            print(f"✓ Successfully connected to PostgreSQL!")
            print(f"  Database version: {db_version[0][:50]}...")
            
            # Get current database info
            self.cursor.execute("SELECT current_database(), current_user;")
            db_info = self.cursor.fetchone()
            print(f"  Database: {db_info[0]}, User: {db_info[1]}")
            
            return True
            
        except Exception as e:
            print(f"✗ Error connecting to database: {e}")
            return False
    
    def disconnect(self):
        """Close database connection"""
        if self.cursor:
            self.cursor.close()
        if self.conn:
            self.conn.close()
        print("Database connection closed.")
    
    def list_schemas(self):
        """List all schemas in the database"""
        try:
            self.cursor.execute("""
                SELECT schema_name 
                FROM information_schema.schemata 
                WHERE schema_name NOT IN ('pg_catalog', 'information_schema', 'pg_toast')
                ORDER BY schema_name;
            """)
            
            schemas = self.cursor.fetchall()
            
            if schemas:
                print("\nAvailable schemas:")
                for schema in schemas:
                    print(f"  • {schema[0]}")
            else:
                print("\nNo user schemas found.")
                
        except Exception as e:
            print(f"Error listing schemas: {e}")
    
    def list_tables(self, schema='public'):
        """List all tables in a specific schema"""
        try:
            self.cursor.execute("""
                SELECT table_name 
                FROM information_schema.tables 
                WHERE table_schema = %s
                ORDER BY table_name;
            """, (schema,))
            
            tables = self.cursor.fetchall()
            
            if tables:
                print(f"\nTables in schema '{schema}':")
                for table in tables:
                    print(f"  • {table[0]}")
            else:
                print(f"\nNo tables found in schema '{schema}'.")
                
            return [t[0] for t in tables]
                
        except Exception as e:
            print(f"Error listing tables: {e}")
            return []
    
    def describe_table(self, table_name, schema='public'):
        """Describe table structure"""
        try:
            self.cursor.execute("""
                SELECT 
                    column_name,
                    data_type,
                    character_maximum_length,
                    is_nullable,
                    column_default
                FROM information_schema.columns
                WHERE table_schema = %s AND table_name = %s
                ORDER BY ordinal_position;
            """, (schema, table_name))
            
            columns = self.cursor.fetchall()
            
            if columns:
                print(f"\nTable structure for '{schema}.{table_name}':")
                headers = ['Column', 'Type', 'Max Length', 'Nullable', 'Default']
                rows = []
                for col in columns:
                    rows.append([
                        col[0],
                        col[1],
                        col[2] or '-',
                        col[3],
                        col[4] or '-'
                    ])
                print(tabulate(rows, headers=headers, tablefmt='grid'))
            else:
                print(f"\nTable '{schema}.{table_name}' not found.")
                
        except Exception as e:
            print(f"Error describing table: {e}")
    
    def execute_query(self, query, params=None):
        """Execute a query and return results"""
        try:
            self.cursor.execute(query, params)
            
            # Check if the query returns results
            if self.cursor.description:
                # Fetch column names
                columns = [desc[0] for desc in self.cursor.description]
                
                # Fetch all results
                results = self.cursor.fetchall()
                
                if results:
                    print(f"\nQuery returned {len(results)} row(s):")
                    print(tabulate(results, headers=columns, tablefmt='grid'))
                else:
                    print("\nQuery returned no results.")
                
                return columns, results
            else:
                # For queries that don't return results (INSERT, UPDATE, DELETE)
                print(f"\nQuery executed successfully. Rows affected: {self.cursor.rowcount}")
                return None, None
                
        except Exception as e:
            print(f"Error executing query: {e}")
            self.conn.rollback()
            return None, None
    
    def create_table(self, table_name, columns, schema='public'):
        """Create a new table"""
        try:
            # Build CREATE TABLE statement
            col_definitions = []
            for col_name, col_type in columns.items():
                col_definitions.append(f"{col_name} {col_type}")
            
            create_stmt = sql.SQL("CREATE TABLE {}.{} ({})").format(
                sql.Identifier(schema),
                sql.Identifier(table_name),
                sql.SQL(', ').join(sql.SQL(col_def) for col_def in col_definitions)
            )
            
            self.cursor.execute(create_stmt)
            print(f"✓ Table '{schema}.{table_name}' created successfully.")
            
        except Exception as e:
            print(f"Error creating table: {e}")
            self.conn.rollback()
    
    def insert_data(self, table_name, data, schema='public'):
        """Insert data into a table"""
        try:
            if not data:
                print("No data to insert.")
                return
            
            # Get column names from the first record
            columns = list(data[0].keys())
            
            # Build INSERT statement
            insert_stmt = sql.SQL("INSERT INTO {}.{} ({}) VALUES ({})").format(
                sql.Identifier(schema),
                sql.Identifier(table_name),
                sql.SQL(', ').join(sql.Identifier(col) for col in columns),
                sql.SQL(', ').join(sql.Placeholder() for _ in columns)
            )
            
            # Insert each record
            for record in data:
                values = [record.get(col) for col in columns]
                self.cursor.execute(insert_stmt, values)
            
            print(f"✓ Inserted {len(data)} record(s) into '{schema}.{table_name}'.")
            
        except Exception as e:
            print(f"Error inserting data: {e}")
            self.conn.rollback()
    
    def backup_table(self, table_name, schema='public', filename=None):
        """Backup table data to JSON file"""
        try:
            if not filename:
                filename = f"{table_name}_backup_{datetime.now().strftime('%Y%m%d_%H%M%S')}.json"
            
            # Fetch all data from table
            self.cursor.execute(
                sql.SQL("SELECT * FROM {}.{}").format(
                    sql.Identifier(schema),
                    sql.Identifier(table_name)
                )
            )
            
            columns = [desc[0] for desc in self.cursor.description]
            rows = self.cursor.fetchall()
            
            # Convert to list of dictionaries
            data = []
            for row in rows:
                data.append(dict(zip(columns, row)))
            
            # Save to JSON file
            with open(filename, 'w') as f:
                json.dump(data, f, indent=2, default=str)
            
            print(f"✓ Backed up {len(data)} record(s) to '{filename}'.")
            
        except Exception as e:
            print(f"Error backing up table: {e}")

# Example usage functions
def example_usage():
    """Show example usage of the DatabaseManager"""
    print("""
Example Usage:
--------------
# Create manager instance
db = DatabaseManager()

# Connect to database
if db.connect():
    # List schemas
    db.list_schemas()
    
    # List tables in public schema
    db.list_tables('public')
    
    # Describe a table
    db.describe_table('users', 'public')
    
    # Execute a SELECT query
    db.execute_query("SELECT * FROM users LIMIT 5")
    
    # Create a new table
    db.create_table('test_table', {
        'id': 'SERIAL PRIMARY KEY',
        'name': 'VARCHAR(100) NOT NULL',
        'created_at': 'TIMESTAMP DEFAULT CURRENT_TIMESTAMP'
    })
    
    # Insert data
    db.insert_data('test_table', [
        {'name': 'Test User 1'},
        {'name': 'Test User 2'}
    ])
    
    # Backup a table
    db.backup_table('users')
    
    # Disconnect
    db.disconnect()
""")

if __name__ == "__main__":
    # Show example usage
    example_usage()
    
    # Try to connect
    db = DatabaseManager()
    if db.connect():
        print("\n✓ Database connection established!")
        print("The DatabaseManager instance 'db' is ready for use.")
        print("You can now execute tasks using the various methods available.")
        
        # List available schemas and tables
        db.list_schemas()
        tables = db.list_tables('public')
        
        # Keep connection open for interactive use
        print("\nConnection remains open. Use db.disconnect() when done.")
    else:
        print("\n✗ Could not establish database connection.")
        print("Please check your network connectivity and credentials.")