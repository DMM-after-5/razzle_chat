require 'rails_helper'

describe "Userモデル", type: :model do
  let(:user) { create(:user) }
  
  describe '保存時' do
    context '正常系' do
      it "名前、ニックネーム、email、電話番号、パスワードがあれば登録できる" do
        expect(user).to be_valid
      end
    end
    
    context '異常系' do
      it "名前が空欄だと登録できない" do
        user.name = nil
        user.valid?
        expect(user.errors[:name]).to include("が入力されていません")
      end
      
      it "名前が81文字以上だと登録できない" do
        invalid_name = Faker::Internet.username(specifier: 81)
        user = build(:user, name: invalid_name)
        user.valid?
        expect(user.errors[:name]).to include("は80文字以下にしてください")
      end
      
      it "ニックネームが空欄だと登録できない" do
        user.nickname = nil
        user.valid?
        expect(user.errors[:nickname]).to include("が入力されていません")
      end
      
      it "ニックネームが21文字以上だと登録できない" do
        invalid_nickname = Faker::Internet.username(specifier: 21)
        user = build(:user, nickname: invalid_nickname)
        user.valid?
        expect(user.errors[:nickname]).to include("は20文字以下にしてください")
      end
      
      it "emailが空欄だと登録できない" do
        user.email = nil
        user.valid?
        expect(user.errors[:email]).to include("が入力されていません")
      end
      
      it "登録済みのemailでは登録できない" do
        email = Faker::Internet.email
        create(:user, email: email)
        user2 = build(:user, email: email)
        user2.valid?
        expect(user2.errors[:email]).to include("は既に使用されています")
      end
      
      it "電話番号が空欄だと登録できない" do
        user.phone_number = nil
        user.valid?
        expect(user.errors[:phone_number]).to include("が入力されていません")
      end
      
      it "パスワードが空欄だと登録できない" do
        user.password = nil
        user.valid?
        expect(user.errors[:password]).to include("が入力されていません")
      end
      
      it "パスワードが5文字以下だと登録できない" do
        invalid_password = Faker::Internet.password(min_length: 5, max_length: 5)
        user = build(:user, password: invalid_password, password_confirmation: invalid_password)
        user.valid?
        expect(user.errors[:password]).to include("は6文字以上に設定してください")
      end
      
    end
  end
  
  describe 'アソシエーション' do
    it 'ユーザーとメッセージは、1対Nの関係である' do
      expect(User.reflect_on_association(:messages).macro).to eq :has_many
    end
    it 'ユーザーとルームへの参加権は、1対Nの関係である' do
      expect(User.reflect_on_association(:entries).macro).to eq :has_many
    end
    it 'ユーザーとチャットルームは、1対Nの関係である' do
      expect(User.reflect_on_association(:rooms).macro).to eq :has_many
    end
  end
  
end
  