class NotaficationMailer < ApplicationMailer

  def comment_notification(user, post, comment)
    @user = user
    @post = post
    @comment = comment

    mail(to: user.email, subject: 'Новый комментарий на ваш пост')
  end

  def comment_distribution(users, post, comment)
    users.each do |user|
      @user = user
      @post = post
      @comment = comment

      mail(to: user.email, subject: 'Новый комментарий к посту по подписке')
    end
  end

end
