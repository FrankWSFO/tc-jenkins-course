# Exit on any error. 
set -e

# Run the tests
python -m unittest discover -s tests -v