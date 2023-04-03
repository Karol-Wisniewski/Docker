import requests
import sys

def check_connection():
    try:
        frontend_response = requests.get('http://localhost:80')
        if frontend_response.status_code != 200:
            print('Frontend connection failed')
            return False

        backend_response = requests.get('http://localhost:4000/health')
        if backend_response.status_code != 200:
            print('Backend connection failed')
            return False

        backend_db_response = requests.get('http://localhost:4000/db_health')
        if backend_db_response.status_code != 200:
            print('Backend connection to the database failed')
            return False

    except Exception as e:
        print(f'Error: {e}')
        return False

    return True

if __name__ == "__main__":
    if check_connection():
        print('All services are connected successfully')
        sys.exit(0)
    else:
        print('Connection check failed')
        sys.exit(1)