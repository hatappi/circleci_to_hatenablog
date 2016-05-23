class FotoLife
  def initialize(consumer_key, consumer_secret, access_token, access_token_secret)
    consumer = OAuth::Consumer.new(
      consumer_key,
      consumer_secret,
      site: 'http://f.hatena.ne.jp'
    )

    @access_token = OAuth::AccessToken.new(
      consumer,
      access_token,
      access_token_secret
    )
  end

  # 画像をはてなフォトライフにアップロードする
  # @param file_path [String] 画像のパス
  # @return [String] http://cdn-ak.f.st-hatena.com/images/fotolife/k/xxxx/yyyy/zzzzz.jpg
  def upload_image(file_path)
    title = File.basename(file_path, '.*')
    header = {'Accept'=>'application/xml', 'Content-Type' => 'application/xml'}
    content = Base64.encode64(open(file_path).read)
    body =<<-"EOF"
<entry xmlns=http://purl.org/atom/ns>
  <title>#{title}</title>
  <content mode='base64'  type='image/jpeg'>#{content}</content>
</entry>
  EOF
    response = @access_token.request(:post, '/atom/post', body, header)
    response.body =~ /<hatena:imageurl>(.*?)<\/hatena:imageurl>/
    $1
  end
end
