function compile
    arduino-cli compile
end

function upload
    tuios send-keys -s arduino-cli -w monitor ctrl+c

    arduino-cli upload

    tuios send-text -s arduino-cli -w monitor \
    "clear
    arduino-cli monitor -p /dev/ttyUSB0 -c baudrate=115200
    "
end
