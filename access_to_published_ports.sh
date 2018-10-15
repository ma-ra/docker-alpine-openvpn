awk '
{
    cmd = "docker inspect --format \"{{ .NetworkSettings.IPAddress }}\" openvpn"
    if (cmd | getline > 0) { openvpn_container_ip=$0"/32" }
    close(cmd)
    
    cmd = "iptables -t nat -S"
    while (cmd | getline > 0) { 
        if ($0 ~ /-A DOCKER.*! -i docker0.*DNAT --to-destination/) { 
            gsub("! -i docker0","-s "openvpn_container_ip,$0)
            gsub("-A DOCKER","iptables -t nat -I DOCKER 1",$0) 
            print $0
            cmd2=$0
            if (cmd2 | getline > 0) { print $0 }
            close(cmd2)
        }
    }
    close (cmd)
}
' - <<< ""
