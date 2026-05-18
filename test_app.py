import pytest
from app import app

@pytest.fixture
def client():
    with app.test_client() as client:
        yield client

def test_healthz(client):
    response = client.get('/healthz')
    assert response.status_code == 200
    assert response.json == {"status": "ok"}