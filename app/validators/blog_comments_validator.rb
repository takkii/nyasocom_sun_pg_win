class BlogCommentsValidator < ActiveModel::EachValidator
  def validate_each(blog_comments, review, value)
    return if value.blank?
    
    blacklist = File.read('./config/blacklist.yml')
    black_yml = YAML.load(blacklist)
    
    unless value.match( /#{black_yml}/o) || {}[:match]
    	blog_comments.errors.add('The conditional expression returned true.')
    end
  end
end