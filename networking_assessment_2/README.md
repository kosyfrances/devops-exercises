# Assessment 02 - Networking

This contains a list of questions to assess a fellows knowledge of the **Networking** Learning Outcome

## Questions

1. Display network interfaces

	```
  	ip addr
  	```

2. Display network routing table

  	```
  	route -n
  	```

3. Disable **ICMP** ping requests to your local machine

    ```
    Add the following iptables rules to block the PING with an error message. (Use REJECT as Jump to target)

    iptables -A INPUT -p icmp --icmp-type echo-request -j REJECT
    ```

4. Use a subnet mask to allocate IP addresses on a network

    Given the ip range **10.0.10.0/24**

    ```
    minimum_ip_address="10.0.10.1"
    maximum_ip_address="10.0.10.254"
    ```

    Given the ip range **10.0.10.0/30**

    ```
    minimum_ip_address="10.0.10.1"
    maximum_ip_address="10.0.10.2"
    ```

5. Use `ssh` to forward port **2444** on remote machine **10.0.0.1** to local port **6333**

    ```
    ssh -L <local port>:<remote computer>:<remote port> <user>@<remote ip>
    ssh -L 6333:10.0.0.1:2444 user@10.0.0.1
    ```

6. Using `ssh` with authentication agent forwarded, connect to remote machine **10.0.0.1**

    ```
    ssh -A user@10.0.0.1
    ```

7. Using `ssh`, connect to remote machine **10.0.0.1** with the private key `private.key.pem`

    ```
    ssh -i private.key.pem user@10.0.0.1
    ```

8. Using `scp`, copy file `/home/user/file.txt` on remote machine **10.0.0.1** to your local machine

    ```
    scp remoteuser@10.0.0.1:/home/user/file.txt /localdirectory/test
    ```

9. Using `scp`, copy local file at `/home/user/file.txt` to remote machine **10.0.0.1**

    ```
    scp -r /home/user/file.txt remoteuser@10.0.0.1:/home/user
    ```

10. List all open ports on a system

    ```
    sudo netstat -tulpen
    ```

11. Block ip address from accessing all ports on your local machine using iptables

    ```
    command goes here
    ```

12. List differences between IPV4 & IPV6 addresses

    ```
    i. IPv4 addresses are 32 bit length while IPv6 addresses are 128 bit length.

    ii. IPv4 addresses are binary numbers represented in decimals while IPv6 addresses are binary numbers represented in hexadecimals.

    iii. Broadcast messages are available in IPv4 while Broadcast messages are not available in IPv6. Instead a link-local scope "All nodes" multicast IPv6 address (FF02::1) is used for broadcast similar functionality.

    iv. Manual configuration (Static) of IPv4 addresses or DHCP (Dynamic configuration) is required to configure IPv4 addresses while Auto-configuration of addresses is available for IPv6.
    ```
