class UserMailer < ApplicationMailer
    default from: ENV['GMAIL_LOGIN']
 
    def command_email(order)
      #on récupère l'instance user pour ensuite pouvoir la passer à la view en @user
      @user = order.user  
      @order = order    
      # c'est cet appel à mail() qui permet d'envoyer l’e-mail en définissant destinataire et sujet.
      mail(to: @user.email, subject: "Merci d'avoir passé commande chez nous !") 
     
    end

    def admin_command_email(order)
      #on récupère l'instance user pour ensuite pouvoir la passer à la view en @user
      @order = order    
      # c'est cet appel à mail() qui permet d'envoyer l’e-mail en définissant destinataire et sujet.
      mail(to: "catadmin@yopmail.com", subject: "Merci d'avoir passé commande chez nous !") 
     
    end

end
