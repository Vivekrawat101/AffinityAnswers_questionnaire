import re
import requests

# test_addresses = [
#     "2nd Phase, 374/B, 80 Feet Rd, Mysore Bank Colony, Banashankari 3rd Stage, Srinivasa Nagar, Bengaluru, Karnataka 560050",
#     "2nd Phase, 374/B, 80 Feet Rd, Bank Colony, Banashankari 3rd Stage, Srinivasa Nagar, Bengaluru, Karnataka 560050",
#     "374/B, 80 Feet Rd, State Bank Colony, Banashankari 3rd Stage, Srinivasa Nagar, Bangalore. 560050",
#     "2nd Phase, 374/B, 80 Feet Rd, Mysore Bank Colony, Banashankari 3rd Stage, Srinivasa Nagar, Bengaluru, Karnataka 560095",
#     "Colony, Bengaluru, Karnataka 560050"
# ]

address = input("Enter a free-flowing address: ")

# regular expression pattern to match the PIN code (6-digit number).
pincode_pattern = r'\b\d{6}\b'


match = re.search(pincode_pattern, address)

if match:
    pincode = match.group()
    print("PIN code:", pincode)
    print()
        
    # API URL
    api_url = f"https://api.postalpincode.in/pincode/{pincode}"
    headers = {
     "method" : "GET",
     "Content-Type": "application/json;" }
        # Send a GET request to the API
    response = requests.get(api_url,headers=headers)
    ctr = 0
    if response.status_code == 200:
        api_data = response.json()
        # Extracting all postoffices associated with pincode.
        post_offices = api_data[0]["PostOffice"]
            
        for office in post_offices:
            # If office name is present in the address, pincode is correct.
            if office["Name"] in address :
                ctr = ctr+1
                break
            
        if ctr == 1:
            print("PIN code corresponds to the address")
        else :
            print("Address is incorrect")

             

    else:
        print("404")
else:
    print("No PIN code found in the address.")

