// script.js
document.addEventListener("DOMContentLoaded", function() {
    var socket = new WebSocket("ws://192.168.1.8:8765");

    socket.onopen = function() {
        console.log("Connected to the server");
    };

    socket.onmessage = function(event) {
        // Parse the JSON data
        var data = JSON.parse(event.data);

        // Update the HTML content with the two integer values
        document.getElementById("HeartRate").textContent = ": " + data.HeartRate;
        document.getElementById("Step").textContent = ": " + data.Step;
    };

    socket.onclose = function() {
        console.log("Disconnected from the server");
    };
});
