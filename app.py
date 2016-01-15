import json

import falcon
import rethinkdb
from rethinkdb.errors import ReqlOpFailedError


HOST = 'localhost'
PORT = 28015

# Datbase is todo and table is notes
DB = 'todo'
TABLE = 'notes'

# Set up db connection client
db_connection = rethinkdb.connect(HOST, PORT)


class NoteResource:
    """
    REST API handlers
    """

    def on_get(self, req, resp):
        """
        Handles of GET requests
        """
        # Return note for particular ID
        if req.get_param('id'):
            result = {
                'note': rethinkdb.db(DB).table(TABLE).get(
                    req.get_param('id')
                ).run(db_connection)
            }
        else:
            note_cursor = rethinkdb.db(DB).table(TABLE).run(db_connection)
            result = {'notes': [i for i in note_cursor]}

        resp.body = json.dumps(result)

    def on_post(self, req, resp):
        """
        Handles of POST requests
        """
        try:
            body = req.stream.read()
        except Exception as ex:
            raise falcon.HTTPError(falcon.HTTP_400, 'Error', ex.message)

        try:
            result = json.loads(body.decode('utf-8'))
            sid = rethinkdb.db(DB).table(TABLE).insert(
                {'title': result['title'], 'body': result['body']}
            ).run(db_connection)
            resp.body = 'Successfully inserted %s' % sid
        except ValueError:
            raise falcon.HTTPError(
                falcon.HTTP_400,
                'Invalid JSON',
                'Could not decode the request body. The JSON was incorrect.'
            )


def db_setup():
    """
    Function is for cross-checking database and table exists
    """
    try:
        rethinkdb.db_create(DB).run(db_connection)
        print('Database setup completed.')
    except ReqlOpFailedError:
        print('Database already exists. Nothing to do.')

    try:
        rethinkdb.db(DB).table_create(TABLE).run(db_connection)
        print('Table creation completed.')
    except ReqlOpFailedError:
        print('Table already exists. Nothing to do.')


db_setup()

api = falcon.API()
api.add_route('/notes', NoteResource())
