ganache_port=7545

ganache_running() {
  nc -z localhost "$ganache_port"
}

pid=$(cat ganache.pid | grep -E '\d+')

if ganache_running; then
    echo "Delete existing ganache process pid: $pid"
    kill -9 $pid
fi
