Stressinator = Stressinator or {}
local st = Stressinator

function st.runStress(times)
  local stopwatch = "demonnictorturetest"
  local latency = getNetworkLatency() * 1000
  latency = latency > 0 and f"{latency}ms" or "N/A"
  createStopWatch(stopwatch, false)
  resetStopWatch(stopwatch)
  startStopWatch(stopwatch)
  for i = 1, times do
    feedTriggers("\nTesting 1, 2, 3. This is a test of your trigger system. This is only a test. Do not be alarmed. All your buffer are belong to us.\n")
  end
  local totalTimeMS = stopStopWatch(stopwatch) * 1000
  local perLine = totalTimeMS / times
  echo("Stress test complete, here's what we know:\n")
  cecho(f"<green>Total lines processed: <firebrick>{times}\n")
  cecho(f"<green>Total time taken: <firebrick>{totalTimeMS / 1000}s\n")
  cecho(f"<green>Time taken per line: <firebrick>{perLine}ms\n")
  cecho(f"<green>Network Latency: <firebrick>{latency}\n")
  cecho(f"<green>Things to keep in mind:\n")
  echo([[  The time for each line includes the time it takes to run feedTriggers itself and the time to check all patterns. This also includes the time it takes for your buffer to delete lines if it gets full, potentially multiple times depending on how large your buffer is and how many lines you have it delete each time. Also the amount of total time your triggers take to match will go up the more of those triggers actually do match, but this test gives an idea over the overhead your triggers may be causing per line received from the game. Network Latency is provided if available as a comparison point for how long it takes the server to get back to you. It is only available if your game provides a GA, EOR, or similar signal with alongside the prompt.]])
end

function st.stop()
  if st.timerID then
    killTimer(st.timerID)
    cecho(f"\n<green>Stress test canceled!\n")
    st.timerID = false
  end
end

function st.stressTest(times)
  if st.timerID then killTimer(st.timerID) end
  times = tonumber(times) or 10000
  cecho(f"\n<green>Beginning stress test in <b><yellow>5<green></b> seconds. Your buffer is going to flood with <b><red>{times}</b><green> lines. Use the alias '<orange>waitno<green>' to stop it\n")
  st.timerID = tempTimer(5, function() st.runStress(times) end)
end