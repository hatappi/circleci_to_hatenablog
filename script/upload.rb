# -*- coding: utf-8 -*-
require 'hatenablog'
require 'kconv'
require 'base64'
require 'oauth'
require 'yaml'
require './foto_life.rb'

config = YAML.load_file('./config.yml')
foto_life = FotoLife.new(
  config['consumer_key'],
  config['consumer_secret'],
  config['access_token'],
  config['access_token_secret']
  )

path = File.open('./file.txt').read.strip
file_path = "../#{path}"
# 本文を取り出す
contents = ""
# タイトルを取り出す
title = 'タイトル無し'
File.open(file_path, 'r:utf-8') do |f|
  f.each_line do |line|
    # タイトル取得
    m = line.match('\A#([^#]+)')
    title = m[1] unless m.nil?
    # 画像を置換
    match = line.match('(!\[(.*)\]\((.+)\))')
    if match
      # 画像をアップロードして置換する
      photo_path = File.dirname(file_path) + '/' + match[3]
      image_url = foto_life.upload(photo_path)
      line.gsub!(/!\[(.*)\]\((.+)\)/, "![#{match[2]}](#{image_url})")
    end
    contents << line
  end
end

# はてなブログに投稿する
Hatenablog::Client.create do |blog|
  blog.post_entry(
    title,
    contents,
    [],
    'yes'
  )
end
