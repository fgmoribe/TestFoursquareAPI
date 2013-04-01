TestFoursquareAPI
================================

This is a simple iOS app, to test the Foursquare API (Venue database search) and using AFNetworking framework.
When executed, the app seach for close venues based on the device gps localization (latitude and longitude).


For usage you must create a file foursquare.plist to include your Foursquare API credentials and include it to the project in xcode as the following:

    <?xml version="1.0" encoding="UTF-8"?>
    <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
    <plist version="1.0">
    <dict>
      <key>client_secret</key>
    	<string>replace_to_your_client_secret</string>
    	<key>client_id</key>
    	<string>replace_to_your_client_id</string>
    </dict>
    </plist>
    
    
For more information about AFNetworking: http://afnetworking.com
For more information about Foursquare API (Venues Platform): https://developer.foursquare.com/overview/venues.html


Any questions email me: fgmoribe at gmail.com
