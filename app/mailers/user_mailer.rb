class UserMailer < ApplicationMailer
    default from: 'visualdai@gmail.com'
 
    def command_email(order)
      #on récupère l'instance user pour ensuite pouvoir la passer à la view en @user
      @user = order.user  
      @order = order    
      #on définit une variable @url qu'on utilisera dans la view d’e-mail
      @url  = 'http://monsite.fr/login' 
     
      # attachments['filename.jpg'] = File.read(order.items[0].cat_picture.path)
      # c'est cet appel à mail() qui permet d'envoyer l’e-mail en définissant destinataire et sujet.
      mail(to: @user.email, subject: "Merci d'avoir passé commande chez nous !") 
      mail(to: "catadmin@yopmail.com", subject: "Un client à passé commande chez nous !") 
    end

    

end
