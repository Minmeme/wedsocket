import asyncio
import websockets
import json

async def send_integers(websocket, path):
    print("Client connected")
   #  await websocket.send(json.dumps("connect successfully"))
    try:
        HeartRate = 0
        Step = 100
        while True:
            # Send two integer values to the client
            data = {
                "HeartRate": HeartRate,
                "Step": Step
            }
            await websocket.send(json.dumps(data))
            HeartRate += 1
            Step += 1
            await asyncio.sleep(1)  # Send integers every second

    except Exception as e:
        print(f"Error: {e}")

    finally:
        print("Client disconnected")

async def main():
    server = await websockets.serve(send_integers, "0.0.0.0", 8765)
    print("Server started at ws://0.0.0.0:8765")
    await server.wait_closed()

# Run the server
asyncio.run(main())
