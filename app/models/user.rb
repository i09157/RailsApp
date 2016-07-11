class User < ApplicationRecord
 
#エラーのパターン
validate :add_error_sample 
 
  def add_error_sample
    #名前が空のとき
    if name.blank?
      errors[:base] << "名前は必須項目です"
    end
 
    #パスワードが空のとき
    if pass.blank?
      errors[:base] << "パスワードは必須項目です"
    end

    # 名前が４文字以下の時
    unless name.blank?
      if name.length < 3
       errors[:base] << "名前は４文字以上です"
      end
    end
 
    # パスワードが４文字以下の時
    unless pass.blank?
      if pass.length < 3 
       errors[:base] << "パスワードは４文字以上です"
      end
    end
    
    #名前は半角英数のみ
    unless name.blank?
     if /\A[a-z0-9]+\z/i !~ name
       errors[:base] << "名前は半角英数字で入力してください"
      end
    end
 
    #パスワードは半角英数のみ
    unless pass.blank?
     if /\A[a-z0-9]+\z/i !~ pass
      errors[:base] << "パスワードは半角英数字で入力してください"
     end
    end

    #ユーザ名の重複がある　←未完成

 end
end