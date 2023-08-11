#!/usr/bin/env bash

#./scripts/run_jqf_script.sh /home/lubuntu/JQF-jqf-1.9/scripts/jqf-driver.sh /home/lubuntu/MA/growe-1.0-SNAPSHOT-all.jar
# argument checking
if [ $# -ne 2 ]; then
  echo "Needs exactly 2 arguments: JQF Driver Path and Jar Path"
  exit 1
fi

# argument renaming
DRIVER_PATH="$1"
JAR_PATH="$2"

function log() {
  echo "$1" | tee -a "$LOGFILE"
}

DURATIONHOURS=2
DURATIONSECONDS=$((DURATIONHOURS * 60 * 60))
ITERATIONS=1500

PLOT_DATA_SAVE_DIR="./plot_data"
LOGFILE="./executor.log"
EXEC_DIR="$(date +"%Y-%m-%d_%H-%M-%S")-$DURATIONHOURS"

# method declaration
function savePlotData() {
  # if plot data directory does not exist
  if [ ! -d "$PLOT_DATA_SAVE_DIR" ]; then
    mkdir -p "$PLOT_DATA_SAVE_DIR"
  fi
  # copy passed executions plot data and rename it meaningful
  cp "$1" "$PLOT_DATA_SAVE_DIR/plot_data.csv"
}

function executeTest() {

  #core execution
  log ""
  # log "===== Executing $CURRENT_METHOD  ====="
  log "===== Executing  ====="
  export JVM_OPTS="$JVM_OPTS -Djqf.ei.MAX_INPUT_SIZE=204800"
  export JVM_OPTS="$JVM_OPTS -Djqf.logCoverage=true"
  export JVM_OPTS="$JVM_OPTS -Djqf.ei.QUIET_MODE=false"

  #ei guidance
  export JVM_OPTS="$JVM_OPTS -Djqf.tracing.MATCH_CALLEE_NAMES=true -Djqf.tracing.TRACE_GENERATORS=true"

  /usr/bin/env bash -c "$DRIVER_PATH --illegal-access=permit -Xmx4G -jar $JAR_PATH -d $DURATIONSECONDS -i $ITERATIONS | tee -a $LOGFILE 2>/dev/null"

  rm -r work/
  rm -r .nextflow/
  
  # log "Archiving working directory..."
  # zip -r "$BASEDIR/work.zip" "$WORKING_DIR" && rm -r "$WORKING_DIR"
}

# execution preparation
mkdir -p "$EXEC_DIR" || return 1
cd "$EXEC_DIR" || return 1

executeTest

echo ""
echo "===== DONE ====="