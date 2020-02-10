class Sale < ActiveRecord::Base

# define a class method, Active Record scope
def self.active 
  where("sales.starts_on <= ? AND sales.ends_on >= ?",
    Date.current, Date.current).any?
end


def finished?
  ends_on < Date.current
end

def upcoming?
  starts_on > Date.current
end

def active?
  starts_on < Date.current && ends_on > Date.current
end

end
