require "pry"

def consolidate_cart(cart)
  new_hash = {}
  cart.each do |item|
    item.each do |name, detail|
      if not new_hash[name]
        new_hash[name] = detail
        new_hash[name][:count] = 1
      else
        new_hash[name][:count] += 1
      end
    end
  end
  new_hash
end

def apply_coupons(cart, coupons)

  # binding.pry
  i = 0
  while i < coupons.length
    if cart.keys.include?(coupons[i][:item]) && cart[(coupons[i][:item])][:count] >= coupons[i][:num]
      
      cart[(coupons[i][:item])][:count] -= coupons[i][:num]
      cart[(coupons[i][:item]) + " W/COUPON"] = {price: coupons[i][:cost], clearance: cart[(coupons[i][:item])][:clearance], count: 1}
      i+=1
    else
      i+=1
    end
  end
  # binding.pry
  cart
end

def apply_clearance(cart)
  
  cart.each do |name, details|
    if details[:clearance] == true
      details[:price] = (details[:price]/5)*4
    end
  end
  cart
end

def checkout(cart, coupons)
  binding.pry
  consolidate_cart(cart)
  apply_coupons(cart, coupons)
  apply_clearance(cart)
  total = 0
  
  cart.each do |name, details|
    total += details[:price] * details[:count]
  end
  if total > 100
    total = total / 10 * 9
  end
  total
end
