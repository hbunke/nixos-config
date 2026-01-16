{ config, pkgs, ... }:

{
  services.davmail = {
    enable = true;
    url = "https://owa.tib.eu/owa";
    
    config = {
      
      # Don't allow remote connections
      davmail.allowRemote = false;

      # Don't require client to use ssl when connecting
      davmail.ssl.nosecurecaldav = false;
      davmail.ssl.nosecureimap = false;
      davmail.ssl.nosecureldap = false;
      davmail.ssl.nosecuresmtp = false;
      davmail.ssl.nosecure = false;
      
      davmail.server = {
        enable = true;

        # this is host specific! 
        certificate.hash = "E4:35:55:22:6E:C0:6A:E7:E1:E5:38:12:E9:68:CF:3A:31:74:E1:30"; 
      };

      # Exchange details TIB
      davmail.mode = "Auto";
      davmail.defaultDomain = "TIB";
      
      
      # Delete messages immediately on IMAP STORE \Deleted flag
      davmail.imapAutoExpunge = false;
      
      # When a message is sent, put it in the sent folder
      davmail.smtpSaveInSent = false; # done by mutt
      
      # Send keepalive character during large folder and messages download
      davmail.enableKeepAlive = true;

      # Ports to listen on
      davmail.caldavPort = 1080;
      davmail.imapPort = 11143;
      davmail.ldapPort = 1389;
      davmail.smtpPort = 10025;  

    };
  };
 

}