=begin
took only 2 days, thank you visual studio code intellisense or whatever they call it, autocomplete
used google to google how to use ruby and which are what
Still learning
Ruby is pretty simple after all...
=end



# Satellite data with health and signal metrics
satellite_data = {
    "Alpha" => {"health_percentage" => 100, "signal_strength" => 100},
    "Bravo" => {"health_percentage" => 100, "signal_strength" => 100},
    "Charlie" => {"health_percentage" => 100, "signal_strength" => 100},
    "Echo" => {"health_percentage" => 100, "signal_strength" => 100},
    "Foxtrot" => {"health_percentage" => 100, "signal_strength" => 100},
    "Golf" => {"health_percentage" => 100, "signal_strength" => 100},
    "Hotel" => {"health_percentage" => 100, "signal_strength" => 100},
    "India" => {"health_percentage" => 100, "signal_strength" => 100}
}

# strings
list_of_commands = ["help", "calibrate", "fix", "status", "quit"]
randomtime = [3, 5, 8]  # Store time values, not sleep results

# Apply separate decay for health and signal_strength
def apply_decay_every_3_seconds(satellite_data, randomtime)
    Thread.new do
        loop do
            sleep(randomtime.sample)  # Sleep for a random time before applying decay
            
            # Pick one satellite for health decay
            health_satellite = satellite_data.keys.sample
            health_decay = [-2, -3, -4].sample
            satellite_data[health_satellite]["health_percentage"] = [satellite_data[health_satellite]["health_percentage"] + health_decay, 0].max
            
            # Pick a different satellite for signal_strength decay
            signal_satellite = satellite_data.keys.sample
            signal_decay = [-13, -16, -18].sample
            satellite_data[signal_satellite]["signal_strength"] = [satellite_data[signal_satellite]["signal_strength"] + signal_decay, 0].max
        end  # Added missing 'end' for loop
    end
end

# Display all satellites
def display_satellites(satellite_data)
    puts "\n--- Satellite Status ---"
    satellite_data.each do |name, stats|
        puts "#{name}: Health=#{stats["health_percentage"]}%, Signal=#{stats["signal_strength"]}%"
    end
    puts "------------------------\n"
end

# Start the decay thread
apply_decay_every_3_seconds(satellite_data, randomtime)

# Main loop for user commands
loop do
    puts "\nCommand_Assistant here! Available commands: #{list_of_commands.join(", ")}"
    print "Enter command: "
    user_input = gets.chomp.downcase
    
    case user_input
    when "help"
        puts "Commands available:"
        puts "  status - View all satellites data such as health and signal strength"
        puts "  calibrate - brings signal_strength back to 100% for a satellite"
        puts "  fix - Restore health of a satellite using Kerfus"
        puts "  quit - Exit program"
    
    when "status"
        display_satellites(satellite_data)
    
    when "calibrate"
        puts "Which satellite do you want to calibrate? (#{satellite_data.keys.join(", ")})"
        print "Satellite name: "
        satellite_name = gets.chomp
        
        if satellite_data[satellite_name]
            puts "Calibrating signal strength for #{satellite_name}"
            sleep(1)
            puts "."
            sleep(1)
            puts "."
            sleep(1)
            puts "."
            satellite_data[satellite_name]["signal_strength"] = 100
            puts "#{satellite_name}'s signal strength restored to 100%"
        else
            puts "Invalid satellite name."
        end
    
    when "fix"
        puts "Which satellite needs fixing? (#{satellite_data.keys.join(", ")})"
        print "Satellite name: "
        satellite_name = gets.chomp
        
        if satellite_data[satellite_name]
            puts "Sending Kerfus to fix #{satellite_name}..."
            sleep(2)
            puts "Kerfus is working on #{satellite_name}..."
            sleep(5)
            satellite_data[satellite_name]["health_percentage"] = 100
            puts "Kerfus: '#{satellite_name}' is now fully repaired"
        else
            puts "Invalid satellite name."
        end
    
    when "quit"
        puts "SHUTTING DOWN...."
        break
    
    else
        puts "Invalid input. Type 'help' for a list of commands."
    end
end
