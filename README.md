# binary-keyboard
This project was designed and implemented from scratch as the final project for a Microcontroller Archeticture class, and was completed in collaboration with a lab partner.








# Flow Chart:
   
                                 #######################
                                 ##                   ##
                                 ##   Initial Setup   ##
                                 ##                   ##
                                 #######################
                                            |
                                            |
                                          \ | /
                                           \|/
    ###################          ########################            #######################
    ##               ## <------- ##                    ##         \  ##                   ##
    ##   Clear LCD   ##          ##     Idle State     ## ---------) ##   Input Buttons   ##
    ##               ## -------> ##                    ##         /  ##                   ##
    ###################          ########################            #######################
                                      /|\        /|\                       |
                                     / | \      / | \                      |
                                       |          |                      \ | /
                                       |          |                       \|/
    #########################################     |                  ###############################
    ##                                     ##     |                  ##                           ##
    ##    Activate Easter Egg Indicator    ##     |                  ##   Send Input Charachter   ##
    ##                                     ##     |                  ##                           ##
    #########################################     |                  ###############################
                                      /|\         |                        |
                                     / | \        |                        |
                                       |          |                      \ | /
                                       |          |                       \|/
                               ############################          #################################
                               ##                        ##  /       ##                             ##         
                               ##  Check for Easter Egg  ## (------- ##   Print Charachter to LCD   ##
                               ##                        ##  \       ##                             ##
                               ############################          #################################
                           
                           
