package main

import (
    "fmt"
    "net/http"
)

// Handler function to respond to requests
func handler(w http.ResponseWriter, r *http.Request) {
    fmt.Fprintf(w, "Hello from Go server!")
}

func main() {
    // Set up the route and the handler
    http.HandleFunc("/", handler)

    // Set the port to listen on (8080 is standard for Railway)
    port := "8080"
    fmt.Println("Server running on port " + port)

    // Start the server
    err := http.ListenAndServe(":"+port, nil)
    if err != nil {
        fmt.Println("Error starting server:", err)
    }
}
