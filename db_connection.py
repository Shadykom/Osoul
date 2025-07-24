import psycopg2
from psycopg2 import sql
import sys

# Database connection parameters
DB_PARAMS = {
    'host': 'db.bzlenegoilnswsbanxgb.supabase.co',
    'port': 5432,
    'database': 'postgres',
    'user': 'postgres',
    'password': 'GET@1a123'
}

def connect_to_database():
    """Establish connection to the PostgreSQL database"""
    try:
        # Connect using parameters instead of URL to handle special characters
        conn = psycopg2.connect(**DB_PARAMS)
        conn.autocommit = True
        cursor = conn.cursor()
        
        # Test the connection
        cursor.execute("SELECT version();")
        db_version = cursor.fetchone()
        print(f"Successfully connected to PostgreSQL!")
        print(f"Database version: {db_version[0]}")
        
        # Get current database name
        cursor.execute("SELECT current_database();")
        current_db = cursor.fetchone()
        print(f"Current database: {current_db[0]}")
        
        # Get current user
        cursor.execute("SELECT current_user;")
        current_user = cursor.fetchone()
        print(f"Connected as user: {current_user[0]}")
        
        return conn, cursor
        
    except Exception as e:
        print(f"Error connecting to database: {e}")
        sys.exit(1)

def list_tables(cursor):
    """List all tables in the current schema"""
    try:
        cursor.execute("""
            SELECT table_schema, table_name 
            FROM information_schema.tables 
            WHERE table_schema NOT IN ('pg_catalog', 'information_schema')
            ORDER BY table_schema, table_name;
        """)
        
        tables = cursor.fetchall()
        
        if tables:
            print("\nAvailable tables:")
            for schema, table in tables:
                print(f"  - {schema}.{table}")
        else:
            print("\nNo user tables found in the database.")
            
    except Exception as e:
        print(f"Error listing tables: {e}")

def execute_query(cursor, query):
    """Execute a query and return results"""
    try:
        cursor.execute(query)
        
        # Check if the query returns results
        if cursor.description:
            # Fetch column names
            columns = [desc[0] for desc in cursor.description]
            
            # Fetch all results
            results = cursor.fetchall()
            
            return columns, results
        else:
            # For queries that don't return results (INSERT, UPDATE, DELETE)
            return None, None
            
    except Exception as e:
        print(f"Error executing query: {e}")
        return None, None

if __name__ == "__main__":
    # Connect to the database
    print("Connecting to PostgreSQL database...")
    conn, cursor = connect_to_database()
    
    # List available tables
    list_tables(cursor)
    
    print("\nDatabase connection established and ready for tasks!")
    print("You can now use the 'conn' and 'cursor' objects to execute queries.")