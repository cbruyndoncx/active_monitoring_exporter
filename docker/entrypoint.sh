#!/bin/bash
touch result.txt
node app.js &
while true; do 
    TESTS=$(ls -l checks/ | awk '{print $9}' | sed 's/.js//')
    echo '# HELP active_monitoring_success Active test success by test and target' > tmp
    echo '# TYPE active_monitoring_success gauge' >> tmp
    echo '# HELP active_monitoring_runtime Active test runtime by test and target' > tmp.runtime
    echo '# TYPE active_monitoring_runtime gauge' >> tmp.runtime
    for TEST in $TESTS; do
        TARGETS=$(cat targets/$TEST)
        for TARGET in $TARGETS; do
            export BASE_URL=$TARGET
            START=`date +%s%3N`
            npx codeceptjs run checks/${TEST}.js &> monitoring.log
            END=`date +%s%3N`
            RUNTIME=$((END-START))
            if [ $? -eq 0 ]; then
                echo "active_monitoring_success{test=\"$TEST\",target=\"$TARGET\"} 1" >> tmp
            else
                echo "active_monitoring_success{test=\"$TEST\",target=\"$TARGET\"} 0" >> tmp
            fi
            echo "active_monitoring_runtime{test=\"$TEST\",target=\"$TARGET\"} $RUNTIME" >> tmp.runtime
        done
    done
    mv tmp result.txt
    cat tmp.runtime >> result.txt
    sleep 10
done
