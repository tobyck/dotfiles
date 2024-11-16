# The `take` command from Oh My Zsh (https://github.com/ohmyzsh/ohmyzsh/wiki/Cheatsheet#commands)

# Do nothing if no args were passed
if test (count $argv) = 0
	echo Please provide at laest one argument.
	return 1
end

if test (string sub -s -4 $argv[1]) = ".git" # If the first arg ends with .git
	# If more than two args were passed, error and exit
	if test (count $argv) -gt 2
		echo Error: too many arguments. Expected one or two.
		return 1
	end

	git clone $argv[1] $argv[2] # Clone the repo (optionally into a specific folder)

	if test (count $argv) = 1  # If a second argument wasn't passed
		set folder_name (string match -r '(?<=/)[^/]+(?=.git$)' $argv[1]) # Use the name of the repo as the folder name
	else
		set folder_name $argv[2] # Otherwise, use the specified one
	end

	cd $folder_name
else
	if test (count $argv) -gt 1
		echo Error: too many arguments. Only expected one.
		return 1
	end
	mkdir -p $argv[1]
	cd $argv[1]
end
