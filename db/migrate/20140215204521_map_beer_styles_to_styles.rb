class MapBeerStylesToStyles < ActiveRecord::Migration
  def change
    reversible do |dir|
      dir.up do
        rename_column :beers, :style, :old_style
        add_reference :beers, :style, index: true
        Beer.all.each do |b|
          style = Style.find_or_create_by(name: b.old_style)
          b.update_attribute(:style_id, style)
        end
        remove_column :beers, :old_style
      end
      dir.down do
        add_column :beers, :old_style, :string
        Beer.all.each do |b|
          b.old_style = b.style.name if b.style
        end
        remove_reference :beers, :style
        rename_column :beers, :old_style, :style
      end

    end
  end
end
