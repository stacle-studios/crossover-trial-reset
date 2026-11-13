
# CrossOver Trial Reset Script

This is a **bash script** designed to reset the trial period of **CrossOver** (a popular application for running Windows software on macOS). The script manipulates specific system files and resets timestamps to make CrossOver think it's a fresh installation, effectively extending your trial period.

## Requirements

- Crossover Trial: (obviously)

## How to Run the Script

### 1. Download the Script

Download the `reset_crossover.sh` script to your local machine.

You can do this by cloning or downloading the repository, or by manually copying the script from here.

### 2. Make the Script Executable

After downloading the script, open **Terminal** and navigate to the folder where the script is located. Run the following command to make the script executable:

```bash
chmod +x reset_crossover.sh
```

### 3. Run the Script

Once the script is executable, simply run it by typing the following command in your Terminal:

```bash
./reset_crossover.sh
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
- **Backup your data** before running the script. This script will modify system files related to CrossOver.
- **Use at your own risk**. While the script is tested on macOS, we recommend reviewing the script and performing a test run on a non-production machine if you're unsure.

---

## License

This script is open-source and shared under the **MIT License**. Feel free to modify and use it for personal or educational projects.

---

## Troubleshooting

Open a issue on GitHub. https://github.com/stacle-studios/crossover-trial-reset. Please provide the output of the script
