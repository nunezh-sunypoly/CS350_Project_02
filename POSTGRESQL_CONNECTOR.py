import psycopg2
from dotenv import dotenv_values

secrets=dotenv_values(".env")

def CONNECT_TO_DB(hostname, database, username, password, port):
    return psycopg2.connect(host=hostname,dbname=database,user=username,password=password,port=port)

def main():
    
    connect = None
    cursor  = None
    
    try:
        hostname    =   secrets["HOST_NAME"]
        database    =   secrets["DATABASE"] 
        username    =   secrets["USER_NAME"]
        password    =   secrets["PWD"]
        port        =   secrets["PORT"]
    
        connect = CONNECT_TO_DB(hostname, database, username, password, port)
        cursor  = connect.cursor()
 
        query = ''' SELECT *
                    FROM employment_data
                    WHERE state_id = 2 '''
        
        query_list_tables = ''' SELECT * 
                                FROM information_schema.tables '''

        cursor.execute(query_list_tables)
        connect.commit()
        #cursor.execute(query)
        #connect.commit()

        result = cursor.fetchall()
        columns = [desc[0] for desc in cursor.description]
        for row in result:
            print(dict(zip(columns, row)))
        
    except Exception as error:
        print(error)
        
    finally:
        if cursor is not None:
           cursor.close() 
        if connect is not None:
           connect.close()
        
if  __name__ == "__main__":
    main()