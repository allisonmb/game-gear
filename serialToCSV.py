import serial
import csv
import time


def read_serial_to_csv(port, baud_rate, csv_filename):
    # Open the serial port
    ser = serial.Serial(port, baud_rate, timeout=1)

    # Wait for the serial connection to initialize
    time.sleep(2)

    # Open the CSV file in append mode
    with open(csv_filename, 'a', newline='') as csvfile:
        csvwriter = csv.writer(csvfile)

        try:
            while True:
                serial_line = ser.readline().decode('utf-8').strip()

                if serial_line:
                    print(f"Received: {serial_line}")
                    csvwriter.writerow([serial_line])

        except KeyboardInterrupt:
            # Handle Ctrl+C interruption
            print("Serial reading stopped by user.")

        finally:
            # Close the serial connection and the CSV file
            ser.close()
            print("Serial port closed, CSV file saved.")


if __name__ == "__main__":
    port = 'COM4'
    baud_rate = 9600
    csv_filename = 'serial_output.csv'

    # Call the function to start reading serial input and writing to CSV
    read_serial_to_csv(port, baud_rate, csv_filename)