class PostMailer < ApplicationMailer
  def post_mail(post)
  #お問い合わせした人の情報をViewに渡している
    @post = post
  #mailメソッドで実際のメールを送信、toで送り先、subjectが件名
    mail to: @post.user.email, subject: "お問い合わせの確認メール"
  end
end
