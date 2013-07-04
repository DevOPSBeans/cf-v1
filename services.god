script = "/home/sistemas/scripts/vcap.sh"
pids_path = "/var/vcap/sys/run"

%w{vblob}.each do |service|
  %w{gateway}.each do |process|
    puts "#{service}_#{process}"
    God.watch do |w|
      w.name = "#{service}_#{process}"
      w.start = "#{script} start #{service}_#{process}"
      w.stop = "#{script} stop #{service}_#{process}"
      w.restart = "#{script} restart #{service}_#{process}"
      w.start_grace = 20.seconds
      w.restart_grace = 20.seconds
      # we generate pid_file path on fly:
      #   why?
      #     if process == gateway its pid file is #{process}_service
      w.pid_file = "#{pids_path}/" + (process=="gateway"?"service":"#{process}")
      
      w.behavior(:clean_pid_file)
  
      # determine the state on startup    
      w.transition(:init, { true => :up, false => :start }) do |on|      
        on.condition(:process_running) do |c|        
          c.running = true     
        end    
      end     
  
      # determine when process has finished starting    
      w.transition([:start, :restart], :up) do |on|      
        on.condition(:process_running) do |c|        
          c.running = true      
        end       
        # failsafe      
        on.condition(:tries) do |c|        
          c.times = 8        
          c.within = 2.minutes        
          c.transition = :start      
        end    
      end     
  
      # start if process is not running    
      w.transition(:up, :start) do |on|      
        on.condition(:process_exits)    
      end     
  
      # lifecycle    
      w.lifecycle do |on|      
        on.condition(:flapping) do |c|        
          c.to_state = [:start, :restart]        
          c.times = 5        
          c.within = 1.minute        
          c.transition = :unmonitored        
          c.retry_in = 10.minutes        
          c.retry_times = 5        
          c.retry_within = 2.hours
        end
      end    
    end
  end
end
