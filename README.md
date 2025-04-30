
# CrossOver Trial Reset Script

This is a **bash script** designed to reset the trial period of **CrossOver** (a popular application for running Windows software on macOS). The script manipulates specific system files and resets timestamps to make CrossOver think it's a fresh installation, effectively extending your trial period for testing or educational purposes.

## How It Works

The script performs the following actions:

1. **Kills any running instances of CrossOver**: Ensures no processes are actively using the app so that all changes can be applied safely.
2. **Modifies CrossOver’s trial period**: The script changes the `FirstRunDate` and `SULastCheckTime` preferences, which are used to track the trial period. This makes CrossOver think it is a new installation.
3. **Removes update timestamps**: The script finds and removes any `.update-timestamp` files inside the CrossOver bottles to ensure there are no previous markers of trial usage.
4. **Restarts CrossOver**: Once all the changes are applied, the script restarts CrossOver so you can continue using the app.

This script is perfect for users who want to reset the trial period for testing or learning purposes.

## Requirements

- **macOS** (Tested on macOS X)
- **Homebrew** (If `pidof` is missing, it will be automatically installed via Homebrew)

### Dependencies

- `pidof`: This command is used to check if CrossOver is running. If it's not available, it will be installed using Homebrew.

## How to Run the Script

### 1. Download the Script

Download the `reset-crossover.sh` script to your local machine.

You can do this by cloning or downloading the repository, or by manually copying the script from here.

### 2. Make the Script Executable

After downloading the script, open **Terminal** and navigate to the folder where the script is located. Run the following command to make the script executable:

```bash
chmod +x reset-crossover.sh
```

### 3. Run the Script

Once the script is executable, simply run it by typing the following command in your Terminal:

```bash
./reset-crossover.sh
```

The script will automatically:
- Kill any open CrossOver processes.
- Reset the trial period by modifying the necessary preference files.
- Clean up any old update timestamps.
- Restart CrossOver and show a notification to let you know the process is complete.

You should see a success notification when the script finishes running.

## How Does It Work?

The script works by performing the following actions:

1. **Checks if CrossOver is running**: The script checks if CrossOver is currently running. If it is, it kills the process to ensure the changes are applied properly.
2. **Modifies the system preferences**: The script updates specific settings in CrossOver's preference files (`com.codeweavers.CrossOver.plist`) to reset the trial date and the last check time.
3. **Updates the system registry**: It clears relevant registry entries within the CrossOver "bottles" to remove any traces of previous runs that could interfere with the trial reset.
4. **Shows a notification**: Once the reset is complete, a notification will appear informing you that the trial has been reset and bottles have been cleaned.

### Important Notes:
- This script is **intended for educational purposes only**. Using it outside of a testing or educational context may violate CrossOver's terms of service.
- **Backup your data** before running the script. This script will modify system files related to CrossOver.
- **Use at your own risk**. While the script is tested on macOS, we recommend reviewing the script and performing a test run on a non-production machine if you're unsure.

---

## Customizing the Script

You can modify the script to add new features or adjust its behavior. Here are a few ideas:

- **Add a backup option**: You could modify the script to create a backup of the bottles before resetting them.
- **Log the actions**: The script currently logs actions to `/tmp/crossover_reset_log.txt`. You can customize this to store logs in a more permanent location if needed.
- **Schedule the script**: You could use **cron** to schedule this script to run periodically, such as every 15 days, to automate the trial reset process.

---

## License

This script is open-source and shared under the **MIT License**. Feel free to modify and use it for personal or educational projects.

---

## Troubleshooting

If the script doesn't work as expected, here are some common issues and solutions:

- **Script fails to find CrossOver**: Ensure that CrossOver is installed in the default path (`~/Applications/CrossOver.app` or `/Applications/CrossOver.app`). If you have CrossOver in a custom location, modify the script to reflect the correct path.
- **`pidof` command not found**: The script will automatically install `pidof` if it’s missing. Make sure you have Homebrew installed for this to work.
