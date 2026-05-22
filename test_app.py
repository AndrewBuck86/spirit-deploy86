import pytest
from app import app

@pytest.fixture
def client():
    app.config['TESTING'] = True
    with app.test_client() as client:
        yield client

def test_hello_endpoint(client):
    """Valida que el endpoint principal responda correctamente."""
    res = client.get('/')
    assert res.status_code == 200
    assert b"Spirit-Deploy86" in res.data