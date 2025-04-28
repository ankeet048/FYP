#!/bin/bash

TARGET="http://localhost:8081"
ENDPOINTS=("/login" "/db" "/admin" "/collection")
USER_AGENTS=("Mozilla/5.0" "MongoScraper/1.0" "DatabaseBot/2.1" "PentestTool")
DURATION=300  # 5 minutes attack

echo "[+] Starting MongoDB Express attack simulation"
echo "[+] Target: $TARGET"
echo "[+] Duration: $DURATION seconds"

start_time=$(date +%s)
request_count=0

# Main attack loop
while [ $(( $(date +%s) - start_time )) -lt $DURATION ]; do
    # Select random endpoint
    ENDPOINT=${ENDPOINTS[$RANDOM % ${#ENDPOINTS[@]}]}
    
    # Select random user agent
    UA=${USER_AGENTS[$RANDOM % ${#USER_AGENTS[@]}]}
    
    # Generate random credentials
    USERNAME="admin$(( RANDOM % 1000 ))"
    PASSWORD="pass$(( RANDOM % 10000 ))"
    
    # Send request with curl
    curl -s -X POST "$TARGET$ENDPOINT" \
         -H "User-Agent: $UA" \
         -H "Content-Type: application/x-www-form-urlencoded" \
         -d "username=$USERNAME&password=$PASSWORD" \
         -o /dev/null &
    
    request_count=$((request_count + 1))
    
    # Status update every 100 requests
    if [ $((request_count % 100)) -eq 0 ]; then
        echo "[*] Sent $request_count requests..."
    fi
    
    # Random sleep between 0.01-0.1 seconds
    sleep 0.$(( RANDOM % 10 + 1 ))
done

echo "[+] Attack simulation completed"
echo "[+] Total requests: $request_count"
echo "[+] Check Elasticsearch/Kibana for results"
