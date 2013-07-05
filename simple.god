# vim: filetype=ruby
script = "/home/sistemas/scripts/vcap.sh"
pids_path = "/var/vcap/sys/run"

%w{vblob}.each do |service|
  %w{gateway node}.each do |process|
    God.watch do |w|
      w.name = "#{service}_#{process}"
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
