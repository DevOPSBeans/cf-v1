# vim: filetype=ruby
# This 'god' file is only to check CFv1 services.
script = "/home/sistemas/scripts/vcap.sh"
pids_path = "/var/vcap/sys/run"
log_path = "/var/log/god"

# CFv1 Services in our installation:
# mongodb mysql neo4j postgresql rabbitmq redis vblob 
# %w{vblob rabbitmq}.each do |service|
%w{mongodb mysql neo4j postgresql rabbitmq redis vblob}.each do |service|
  %w{gateway node}.each do |process|
    God.watch do |w|
      w.name = "#{service}_#{process}"
      w.log = "#{log_path}/#{service}.log"
      w.err_log = " #{log_path}/#{service}_err.log"
      w.start = "#{script} start #{service}_#{process}"
      w.stop = "#{script} stop #{service}_#{process}"
      w.restart = "#{script} restart #{service}_#{process}"
      # we generate pid_file path on fly:
      #   why?
      #     if process == gateway its pid file is #{process}_service
      w.pid_file = "#{pids_path}/" + (process=="gateway"?"service":"#{process}")
      w.behavior(:clean_pid_file)
      w.keepalive
     end
  end
end
