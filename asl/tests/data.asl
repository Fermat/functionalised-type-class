module eq where

data Bool where
  true :: Bool
  false :: Bool

and = \ x y . case x of
                true -> y
		false -> false

data Nat where
  z :: Nat
  s :: Nat -> Nat

data List A where
  nil :: List A
  cons :: A -> List A -> List A

class Eq A where
   eq :: Eq A => A -> A -> Bool

instance Eq Nat where
  eq = \ x y . case x of
                 z -> case y of
		         z -> true
			 s n -> false
	         s m -> case y of
                          z -> false
			  s n -> eq m n

instance Eq A => Eq (List A) where
   eq = \ l1 l2 . case l1 of
                    nil -> case l2 of
                             nil -> true
			     cons y ys -> false
                    cons x xs -> case l2 of
		                   nil -> false
				   cons y ys -> and (eq x y) (eq xs ys)

test = eq (cons z nil) (cons z (cons z nil))