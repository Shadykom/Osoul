import socket
import psycopg2
import sys

# Database connection parameters
DB_PARAMS = {
    'host': 'db.bzlenegoilnswsbanxgb.supabase.co',
    'port': 5432,
    'database': 'postgres',
    'user': 'postgres',
    'password': 'GET@1a123'
}

def test_dns_resolution():
    """Test if the hostname can be resolved"""
    try:
        ip = socket.gethostbyname(DB_PARAMS['host'])
        print(f"✓ DNS resolution successful: {DB_PARAMS['host']} -> {ip}")
        return True
    except socket.gaierror as e:
        print(f"✗ DNS resolution failed: {e}")
        return False

def test_port_connectivity():
    """Test if the port is reachable"""
    try:
        sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        sock.settimeout(5)
        result = sock.connect_ex((DB_PARAMS['host'], DB_PARAMS['port']))
        sock.close()
        
        if result == 0:
            print(f"✓ Port {DB_PARAMS['port']} is reachable")
            return True
        else:
            print(f"✗ Port {DB_PARAMS['port']} is not reachable (error code: {result})")
            return False
    except Exception as e:
        print(f"✗ Port connectivity test failed: {e}")
        return False

def test_database_connection():
    """Test the actual database connection"""
    try:
        print("\nAttempting database connection...")
        conn = psycopg2.connect(**DB_PARAMS)
        cursor = conn.cursor()
        cursor.execute("SELECT version();")
        version = cursor.fetchone()
        print(f"✓ Database connection successful!")
        print(f"  PostgreSQL version: {version[0][:50]}...")
        cursor.close()
        conn.close()
        return True
    except Exception as e:
        print(f"✗ Database connection failed: {e}")
        return False

def main():
    print("Database Connection Test")
    print("=" * 50)
    print(f"Host: {DB_PARAMS['host']}")
    print(f"Port: {DB_PARAMS['port']}")
    print(f"Database: {DB_PARAMS['database']}")
    print(f"User: {DB_PARAMS['user']}")
    print("=" * 50)
    
    # Run tests
    dns_ok = test_dns_resolution()
    
    if dns_ok:
        port_ok = test_port_connectivity()
        
        if port_ok:
            db_ok = test_database_connection()
            
            if db_ok:
                print("\n✓ All tests passed! Database is accessible.")
                print("\nYou can now use the db_tasks.py script to perform database operations.")
            else:
                print("\n✗ Database connection failed despite network connectivity.")
                print("Please verify your credentials.")
        else:
            print("\n✗ Cannot reach the database server.")
            print("This might be due to network restrictions or firewall settings.")
    else:
        print("\n✗ Cannot resolve the database hostname.")
        print("Please check your internet connection.")

if __name__ == "__main__":
    main()