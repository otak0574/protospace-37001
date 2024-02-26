class AddOnDeleteCascadeToComments < ActiveRecord::Migration[7.0]
  def change
        # 既存の外部キー制約を削除
    remove_foreign_key :comments, :prototypes

    # on_delete: :cascade オプション付きで外部キー制約を再追加
    add_foreign_key :comments, :prototypes, on_delete: :cascade
  end
end
