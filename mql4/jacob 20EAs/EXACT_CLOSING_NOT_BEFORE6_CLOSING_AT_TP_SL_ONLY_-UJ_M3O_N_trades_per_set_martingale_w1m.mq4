/ / + - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - + / /  
 / / )       _ _ _ _     _     _     _ _ _ _     _ _ _ _     _ _ _ _     _ _ _ _     _ _     _ _         _ _             _ _ _     _ _ _ _ _     _ _     _ _       ( / /  
 / / )     (   _ _ _ ) (   \ /   ) (     _   \ (     _   \ (   _ _ _ ) (   _ _ _ ) (     \ /     )     / _ _ \         /   _ _ ) (     _     ) (     \ /     )     ( / /  
 / / )       ) _ _ )     )     (     ) ( _ )   ) )       /   ) _ _ )     ) _ _ )     )         (     / ( _ _ ) \     (   ( _ _     ) ( _ ) (     )         (       ( / /  
 / / )     ( _ _ )     ( _ / \ _ ) ( _ _ _ _ / ( _ ) \ _ ) ( _ _ _ _ ) ( _ _ _ _ ) ( _ / \ / \ _ ) ( _ _ ) ( _ _ ) ( ) \ _ _ _ ) ( _ _ _ _ _ ) ( _ / \ / \ _ )     ( / /  
 / / )       h t t p s : / / f x d r e e m a . c o m                                                           C o p y r i g h t   2 0 1 9 ,   f x D r e e m a     ( / /  
 / / + - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - + / /  
 # p r o p e r t y   c o p y r i g h t       " B D R   2 0 1 9 "  
 # p r o p e r t y   l i n k                 " h t t p s : / / f x d r e e m a . c o m "  
 # p r o p e r t y   d e s c r i p t i o n   " "  
 # p r o p e r t y   v e r s i o n           " 1 . 0 "  
 # p r o p e r t y   s t r i c t  
  
 / * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * /  
 / /   + - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - +   / /  
 / /   |                                               I N P U T   P A R A M E T E R S ,   G L O B A L   V A R I A B L E S ,   C O N S T A N T S ,   I M P O R T S   a n d   I N C L U D E S                                                 |   / /  
 / /   |                                             S y s t e m   a n d   C u s t o m   v a r i a b l e s   a n d   o t h e r   d e f i n i t i o n s   u s e d   i n   t h e   p r o j e c t                                               |   / /  
 / /   + - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - +   / /  
 / * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * /  
  
 / / V V V V V V V V V V V V V V V V V V V V V V V V V V V V V V V V V V V V V / /  
 / /   S y s t e m   c o n s t a n t s   ( p r o j e c t   s e t t i n g s )   / /  
 / / ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ / /  
 / / - -  
 # d e f i n e   P R O J E C T _ I D   " s i m p l e "  
 / / - -  
 / /   P o i n t   F o r m a t   R u l e s  
 # d e f i n e   P O I N T _ F O R M A T _ R U L E S   " 0 . 0 0 1 = 0 . 0 1 , 0 . 0 0 0 0 1 = 0 . 0 0 0 1 , 0 . 0 0 0 0 0 1 = 0 . 0 0 0 1 "   / /   t h i s   i s   d e s e r i a l i z e d   i n   a   s p e c i a l   f u n c t i o n   l a t e r  
 # d e f i n e   E N A B L E _ S P R E A D _ M E T E R   t r u e  
 # d e f i n e   E N A B L E _ S T A T U S   t r u e  
 # d e f i n e   E N A B L E _ T E S T _ I N D I C A T O R S   t r u e  
 / / - -  
 / /   E v e n t s   O n / O f f  
 # d e f i n e   E N A B L E _ E V E N T _ T I C K   1   / /   e n a b l e   " T i c k "   e v e n t  
 # d e f i n e   E N A B L E _ E V E N T _ T R A D E   0   / /   e n a b l e   " T r a d e "   e v e n t  
 # d e f i n e   E N A B L E _ E V E N T _ T I M E R   0   / /   e n a b l e   " T i m e r "   e v e n t  
 / / - -  
 / /   V i r t u a l   S t o p s  
 # d e f i n e   V I R T U A L _ S T O P S _ E N A B L E D   0   / /   e n a b l e   v i r t u a l   s t o p s  
 # d e f i n e   V I R T U A L _ S T O P S _ T I M E O U T   0   / /   v i r t u a l   s t o p s   t i m e o u t  
 # d e f i n e   U S E _ E M E R G E N C Y _ S T O P S   " n o "   / /   " y e s "   t o   u s e   e m e r g e n c y   ( h a r d   s t o p s )   w h e n   v i r t u a l   s t o p s   a r e   i n   u s e .   " a l w a y s "   t o   u s e   E M E R G E N C Y _ S T O P S _ A D D   a s   e m e r g e n c y   s t o p s   w h e n   t h e r e   i s   n o   v i r t u a l   s t o p .  
 # d e f i n e   E M E R G E N C Y _ S T O P S _ R E L   0   / /   u s e   0   t o   d i s a b l e   h a r d   s t o p s   w h e n   v i r t u a l   s t o p s   a r e   e n a b l e d .   U s e   a   v a l u e   > = 0   t o   a u t o m a t i c a l l y   s e t   h a r d   s t o p s   w i t h   v i r t u a l .   E x a m p l e :   i f   2   i s   u s e d ,   t h e n   h a r d   s t o p s   w i l l   b e   2   t i m e s   b i g g e r   t h a n   v i r t u a l   o n e s .  
 # d e f i n e   E M E R G E N C Y _ S T O P S _ A D D   0   / /   a d d   p i p s   t o   r e l a t i v e   s i z e   o f   e m e r g e n c y   s t o p s   ( h a r d   s t o p s )  
 / / - -  
 / /   S e t t i n g s   f o r   e v e n t s  
 # d e f i n e   O N _ T R A D E _ R E A L T I M E   0   / /  
 # d e f i n e   O N _ T I M E R _ P E R I O D   6 0   / /   T i m e r   e v e n t   p e r i o d   ( i n   s e c o n d s )  
  
 / / V V V V V V V V V V V V V V V V V V V V V V V V V V V V V V V V V V V V V V V V V / /  
 / /   S y s t e m   c o n s t a n t s   ( p r e d e f i n e d   c o n s t a n t s )   / /  
 / / ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ / /  
 / / - -  
 / /   B l o c k s   L o o k u p   F u n c t i o n s  
 s t r i n g   f x d B l o c k s L o o k u p T a b l e [ ] ;  
  
 # d e f i n e   T L O B J P R O P _ T I M E 1   8 0 1  
 # d e f i n e   O B J P R O P _ T L _ P R I C E _ B Y _ S H I F T   8 0 2  
 # d e f i n e   O B J P R O P _ T L _ S H I F T _ B Y _ P R I C E   8 0 3  
 # d e f i n e   O B J P R O P _ F I B O V A L U E   8 0 4  
 # d e f i n e   O B J P R O P _ F I B O P R I C E V A L U E   8 0 5  
 # d e f i n e   O B J P R O P _ B A R S H I F T 1   8 0 7  
 # d e f i n e   O B J P R O P _ B A R S H I F T 2   8 0 8  
 # d e f i n e   O B J P R O P _ B A R S H I F T 3   8 0 9  
 # d e f i n e   S E L _ C U R R E N T   0  
 # d e f i n e   S E L _ I N I T I A L   1  
  
 / / V V V V V V V V V V V V V V V V V V V V V V V V V V V V V V V V V V V V V V V V V V V V V / /  
 / /   E n u m e r a t i o n s ,   I m p o r t s ,   C o n s t a n t s ,   V a r i a b l e s   / /  
 / / ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ / /  
  
  
  
  
 / / - -  
 / /   C o n s t a n t s   ( I n p u t   P a r a m e t e r s )  
 i n p u t   i n t   M a g i c S t a r t   =   4 7 7 9 ;   / /   M a g i c   N u m b e r  
 i n p u t   i n t   N _ t r a d e s _ p e r _ s e t   =   3 ;  
 i n p u t   i n t   T P   =   1 0 0 ;  
 i n p u t   i n t   S L   =   1 0 0 ;  
 c l a s s   c  
 {  
 	 	 p u b l i c :  
 	 s t a t i c   i n t   N _ t r a d e s _ p e r _ s e t ;  
 	 s t a t i c   i n t   S L ;  
 	 s t a t i c   i n t   T P ;  
 	 s t a t i c   i n t   M a g i c S t a r t ;  
 } ;  
 i n t   c : : N _ t r a d e s _ p e r _ s e t ;  
 i n t   c : : S L ;  
 i n t   c : : T P ;  
 i n t   c : : M a g i c S t a r t ;  
  
  
 / / - -  
 / /   V a r i a b l e s   ( G l o b a l   V a r i a b l e s )  
 c l a s s   v  
 {  
 	 	 p u b l i c :  
 	 s t a t i c   i n t   w i n s ;  
 	 s t a t i c   i n t   l o s s e s ;  
 	 s t a t i c   d o u b l e   l o t s ;  
 	 s t a t i c   d o u b l e   t r a d e _ n u m b e r ;  
 	 s t a t i c   d o u b l e   v a l u e _ p i p s ;  
 } ;  
 i n t   v : : w i n s ;  
 i n t   v : : l o s s e s ;  
 d o u b l e   v : : l o t s ;  
 d o u b l e   v : : t r a d e _ n u m b e r ;  
 d o u b l e   v : : v a l u e _ p i p s ;  
  
  
  
 / / - -  
 / /   E x t e r n s   ( G l o b a l   V a r i a b l e s )  
  
 i n p u t   d o u b l e   i n p 1 6 _ R o _ V a l u e   =   2 . 0 ; / /   S c a l e   F a c t o r  
 i n p u t   d o u b l e   i n p 1 3 _ R o _ V a l u e   =   1 0 0 0 0 0 . 0 ;   / /   I n i t i a l   l o t   s i z e :   E q u i t y   /   1 0 0   0 0 0  
 c l a s s   _ e x t e r n s  
 {  
 	 	 p u b l i c :  
 	 s t a t i c   d o u b l e   i n p 1 3 _ R o _ V a l u e ;  
 	 s t a t i c   d o u b l e   i n p 1 6 _ R o _ V a l u e ;  
 } ;  
 d o u b l e   _ e x t e r n s : : i n p 1 3 _ R o _ V a l u e ;  
 d o u b l e   _ e x t e r n s : : i n p 1 6 _ R o _ V a l u e ;  
  
  
  
 / / V V V V V V V V V V V V V V V V V V V V V V V V V / /  
 / /   S y s t e m   g l o b a l   v a r i a b l e s   / /  
 / / ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ / /  
 / / - -  
 i n t   F X D _ C U R R E N T _ F U N C T I O N _ I D   =   0 ;  
 d o u b l e   F X D _ M I L S _ I N I T _ E N D         =   0 ;  
 i n t   F X D _ T I C K S _ F R O M _ S T A R T         =   0 ;  
 i n t   F X D _ M O R E _ S H I F T                     =   0 ;  
 b o o l   F X D _ D R A W _ S P R E A D _ I N F O       =   f a l s e ;  
 b o o l   F X D _ F I R S T _ T I C K _ P A S S E D     =   f a l s e ;  
 b o o l   F X D _ B R E A K                             =   f a l s e ;  
 b o o l   F X D _ C O N T I N U E                       =   f a l s e ;  
 b o o l   F X D _ C H A R T _ I S _ O F F L I N E       =   f a l s e ;  
 b o o l   F X D _ O N T I M E R _ T A K E N             =   f a l s e ;  
 b o o l   F X D _ O N T I M E R _ T A K E N _ I N _ M I L L I S E C O N D S   =   f a l s e ;  
 d o u b l e   F X D _ O N T I M E R _ T A K E N _ T I M E   =   0 ;  
 b o o l   U S E _ V I R T U A L _ S T O P S   =   V I R T U A L _ S T O P S _ E N A B L E D ;  
 s t r i n g   F X D _ C U R R E N T _ S Y M B O L       =   " " ;  
 i n t   F X D _ B L O C K S _ C O U N T                 =   1 6 ;  
 d a t e t i m e   F X D _ T I C K S K I P _ U N T I L   =   0 ;  
  
 / / -   f o r   u s e   i n   O n C h a r t ( )   e v e n t  
 s t r u c t   f x d _ o n c h a r t  
 {  
 	 i n t   i d ;  
 	 l o n g   l p a r a m ;  
 	 d o u b l e   d p a r a m ;  
 	 s t r i n g   s p a r a m ;  
 } ;  
 f x d _ o n c h a r t   F X D _ O N C H A R T ;  
  
 / * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * /  
 / /   + - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - +   / /  
 / /   |                                                                                                   E V E N T   F U N C T I O N S                                                                                                     |   / /  
 / /   |                                                       T h e s e   a r e   t h e   m a i n   f u n c t i o n s   t h a t   c o n t r o l s   t h e   w h o l e   p r o j e c t                                                       |   / /  
 / /   + - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - +   / /  
 / * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * /  
  
 / / V V V V V V V V V V V V V V V V V V V V V V V V V V V V V V V V V V V V V V V V V V V V V V V V V V V V V V V V / /  
 / /   T h i s   f u n c t i o n   i s   e x e c u t e d   o n c e   w h e n   t h e   p r o g r a m   s t a r t s   / /  
 / / ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ / /  
 i n t   O n I n i t ( )  
 {  
  
 	 / /   I n i t i a t e   C o n s t a n t s  
 	 c : : N _ t r a d e s _ p e r _ s e t   =   N _ t r a d e s _ p e r _ s e t ;  
 	 c : : S L   =   S L ;  
 	 c : : T P   =   T P ;  
 	 c : : M a g i c S t a r t   =   M a g i c S t a r t ;  
  
  
  
  
 	 / /   I n i t i a t e   E x t e r n s  
 	 _ e x t e r n s : : i n p 1 3 _ R o _ V a l u e   =   i n p 1 3 _ R o _ V a l u e ;  
 	 _ e x t e r n s : : i n p 1 6 _ R o _ V a l u e   =   i n p 1 6 _ R o _ V a l u e ;  
  
  
  
 	 / /   d o   o r   d o   n o t   n o t   i n i t i l i a l i z e   o n   r e l o a d  
 	 i f   ( U n i n i t i a l i z e R e a s o n ( )   ! =   0 )  
 	 {  
 	 	 i f   ( U n i n i t i a l i z e R e a s o n ( )   = =   R E A S O N _ C H A R T C H A N G E )  
 	 	 {  
 	 	 	 / /   i f   t h e   s y m b o l   i s   t h e   s a m e ,   d o   n o t   r e l o a d ,   o t h e r w i s e   c o n t i n u e   b e l o w  
 	 	 	 i f   ( F X D _ C U R R E N T _ S Y M B O L   = =   S y m b o l ( ) )   { r e t u r n   I N I T _ S U C C E E D E D ; }  
 	 	 }  
 	 	 e l s e  
 	 	 {  
 	 	 	 r e t u r n   I N I T _ S U C C E E D E D ;  
 	 	 }  
 	 }  
 	 F X D _ C U R R E N T _ S Y M B O L   =   S y m b o l ( ) ;  
  
 	 v : : w i n s   =   0 ;  
 	 v : : l o s s e s   =   0 ;  
 	 v : : l o t s   =   0 . 0 1 ;  
 	 v : : t r a d e _ n u m b e r   =   0 . 0 ;  
 	 v : : v a l u e _ p i p s   =   5 . 0 ;  
  
  
  
  
 	 C o m m e n t ( " " ) ;  
 	 f o r   ( i n t   i = O b j e c t s T o t a l ( C h a r t I D ( ) ) ;   i > = 0 ;   i - - )  
 	 {  
 	 	 s t r i n g   n a m e   =   O b j e c t N a m e ( C h a r t I D ( ) ,   i ) ;  
 	 	 i f   ( S t r i n g S u b s t r ( n a m e , 0 , 8 )   = =   " f x d _ c m n t " )   { O b j e c t D e l e t e ( C h a r t I D ( ) ,   n a m e ) ; }  
 	 }  
 	 C h a r t R e d r a w ( ) ;  
  
  
  
 	 / / - -   d i s a b l e   v i r t u a l   s t o p s   i n   o p t i m i z a t i o n ,   b e c a u s e   g r a p h i c a l   o b j e c t s   d o e s   n o t   w o r k  
 	 / /   h t t p : / / d o c s . m q l 4 . c o m / r u n t i m e / t e s t i n g  
 	 i f   ( M Q L I n f o I n t e g e r ( M Q L _ O P T I M I Z A T I O N )   | |   ( M Q L I n f o I n t e g e r ( M Q L _ T E S T E R )   & &   ! M Q L I n f o I n t e g e r ( M Q L _ V I S U A L _ M O D E ) ) )   {  
 	 	 U S E _ V I R T U A L _ S T O P S   =   f a l s e ;  
 	 }  
  
 	 / / - -   s e t   i n i t i a l   l o c a l   a n d   s e r v e r   t i m e  
 	 T i m e A t S t a r t ( " s e t " ) ;  
  
 	 / / - -   s e t   i n i t i a l   b a l a n c e  
 	 A c c o u n t B a l a n c e A t S t a r t ( ) ;  
  
 	 / / - -   d r a w   t h e   i n i t i a l   s p r e a d   i n f o   m e t e r  
 	 i f   ( E N A B L E _ S P R E A D _ M E T E R   = =   f a l s e )   {  
 	 	 F X D _ D R A W _ S P R E A D _ I N F O   =   f a l s e ;  
 	 }  
 	 e l s e   {  
 	 	 F X D _ D R A W _ S P R E A D _ I N F O   =   ! ( M Q L I n f o I n t e g e r ( M Q L _ T E S T E R )   & &   ! M Q L I n f o I n t e g e r ( M Q L _ V I S U A L _ M O D E ) ) ;  
 	 }  
 	 i f   ( F X D _ D R A W _ S P R E A D _ I N F O )   D r a w S p r e a d I n f o ( ) ;  
  
 	 / / - -   d r a w   i n i t i a l   s t a t u s  
 	 i f   ( E N A B L E _ S T A T U S )   D r a w S t a t u s ( " w a i t i n g   f o r   t i c k . . . " ) ;  
  
 	 / / - -   d r a w   i n d i c a t o r s   a f t e r   t e s t  
 	 T e s t e r H i d e I n d i c a t o r s ( ! E N A B L E _ T E S T _ I N D I C A T O R S ) ;  
  
 	 / / - -   w o r k i n g   w i t h   o f f l i n e   c h a r t s  
 	 i f   ( M Q L I n f o I n t e g e r ( M Q L _ P R O G R A M _ T Y P E )   = =   P R O G R A M _ E X P E R T )  
 	 {  
 	 	 F X D _ C H A R T _ I S _ O F F L I N E   =   C h a r t G e t I n t e g e r ( 0 ,   C H A R T _ I S _ O F F L I N E ) ;  
 	 }  
  
 	 i f   ( M Q L I n f o I n t e g e r ( M Q L _ P R O G R A M _ T Y P E )   ! =   P R O G R A M _ S C R I P T )  
 	 {  
 	 	 i f   ( F X D _ C H A R T _ I S _ O F F L I N E   = =   t r u e   | |   ( E N A B L E _ E V E N T _ T R A D E   = =   1   & &   O N _ T R A D E _ R E A L T I M E   = =   1 ) )  
 	 	 {  
 	 	 	 F X D _ O N T I M E R _ T A K E N   =   t r u e ;  
 	 	 	 E v e n t S e t M i l l i s e c o n d T i m e r ( 1 ) ;  
 	 	 }  
 	 	 i f   ( E N A B L E _ E V E N T _ T I M E R )   {  
 	 	 	 O n T i m e r S e t ( O N _ T I M E R _ P E R I O D ) ;  
 	 	 }  
 	 }  
  
 	 i f   ( E N A B L E _ E V E N T _ T R A D E )   O n T r a d e L i s t e n e r ( ) ;   / /   t o   l o a d   i n i t i a l   d a t a b a s e   o f   o r d e r s  
  
  
 	 / / - -   I n i t i a l i z e   b l o c k s   c l a s s e s  
 	 A r r a y R e s i z e ( _ b l o c k s _ ,   1 6 ) ;  
  
 	 _ b l o c k s _ [ 0 ]   =   n e w   B l o c k 0 ( ) ;  
 	 _ b l o c k s _ [ 1 ]   =   n e w   B l o c k 1 ( ) ;  
 	 _ b l o c k s _ [ 2 ]   =   n e w   B l o c k 2 ( ) ;  
 	 _ b l o c k s _ [ 3 ]   =   n e w   B l o c k 3 ( ) ;  
 	 _ b l o c k s _ [ 4 ]   =   n e w   B l o c k 4 ( ) ;  
 	 _ b l o c k s _ [ 5 ]   =   n e w   B l o c k 5 ( ) ;  
 	 _ b l o c k s _ [ 6 ]   =   n e w   B l o c k 6 ( ) ;  
 	 _ b l o c k s _ [ 7 ]   =   n e w   B l o c k 7 ( ) ;  
 	 _ b l o c k s _ [ 8 ]   =   n e w   B l o c k 8 ( ) ;  
 	 _ b l o c k s _ [ 9 ]   =   n e w   B l o c k 9 ( ) ;  
 	 _ b l o c k s _ [ 1 0 ]   =   n e w   B l o c k 1 0 ( ) ;  
 	 _ b l o c k s _ [ 1 1 ]   =   n e w   B l o c k 1 1 ( ) ;  
 	 _ b l o c k s _ [ 1 2 ]   =   n e w   B l o c k 1 2 ( ) ;  
 	 _ b l o c k s _ [ 1 3 ]   =   n e w   B l o c k 1 3 ( ) ;  
 	 _ b l o c k s _ [ 1 4 ]   =   n e w   B l o c k 1 4 ( ) ;  
 	 _ b l o c k s _ [ 1 5 ]   =   n e w   B l o c k 1 5 ( ) ;  
  
 	 / /   f i l l   t h e   l o o k u p   t a b l e  
 	 A r r a y R e s i z e ( f x d B l o c k s L o o k u p T a b l e ,   A r r a y S i z e ( _ b l o c k s _ ) ) ;  
 	 f o r   ( i n t   i = 0 ;   i < A r r a y S i z e ( _ b l o c k s _ ) ;   i + + )  
 	 {  
 	 	 f x d B l o c k s L o o k u p T a b l e [ i ]   =   _ b l o c k s _ [ i ] . _ _ b l o c k _ u s e r _ n u m b e r ;  
 	 }  
  
 	 / /   f i l l   t h e   l i s t   o f   i n b o u n d   b l o c k s   f o r   e a c h   B l o c k C a l l s   i n s t a n c e  
 	 f o r   ( i n t   i = 0 ;   i < A r r a y S i z e ( _ b l o c k s _ ) ;   i + + )  
 	 {  
 	 	 _ b l o c k s _ [ i ] . _ _ a n n o u n c e T h i s B l o c k ( ) ;  
 	 }  
  
 	 / /   L i s t   o f   i n i t i a l l y   d i s a b l e d   b l o c k s  
 	 i n t   d i s a b l e d _ b l o c k s _ l i s t [ ]   =   { } ;  
 	 f o r   ( i n t   l   =   0 ;   l   <   A r r a y S i z e ( d i s a b l e d _ b l o c k s _ l i s t ) ;   l + + )   {  
 	 	 _ b l o c k s _ [ d i s a b l e d _ b l o c k s _ l i s t [ l ] ] . _ _ d i s a b l e d   =   t r u e ;  
 	 }  
  
 	 / / - -   r u n   b l o c k s  
 	 i n t   b l o c k s _ t o _ r u n [ ]   =   { 1 2 } ;  
 	 f o r   ( i n t   i = 0 ;   i < A r r a y S i z e ( b l o c k s _ t o _ r u n ) ;   i + + )   {  
 	 	 _ b l o c k s _ [ b l o c k s _ t o _ r u n [ i ] ] . r u n ( ) ;  
 	 }  
  
  
 	 F X D _ M I L S _ I N I T _ E N D           =   ( d o u b l e ) G e t T i c k C o u n t ( ) ;  
 	 F X D _ F I R S T _ T I C K _ P A S S E D   =   f a l s e ;   / /   r e s e t   i s   n e e d e d   w h e n   c h a n g i n g   i n p u t s  
  
 	 r e t u r n ( I N I T _ S U C C E E D E D ) ;  
 }  
  
 / / V V V V V V V V V V V V V V V V V V V V V V V V V V V V V V V V V V V V V V V V V V V V V V V V V V / /  
 / /   T h i s   f u n c t i o n   i s   e x e c u t e d   o n   e v e r y   i n c o m i n g   t i c k   / /  
 / / ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ / /  
 v o i d   O n T i c k ( )  
 {  
 	 F X D _ T I C K S _ F R O M _ S T A R T + + ;  
  
 	 i f   ( E N A B L E _ S T A T U S   & &   F X D _ T I C K S _ F R O M _ S T A R T   = =   1 )   D r a w S t a t u s ( " w o r k i n g " ) ;  
  
 	 / / - -   s p e c i a l   s y s t e m   a c t i o n s  
 	 i f   ( F X D _ D R A W _ S P R E A D _ I N F O )   D r a w S p r e a d I n f o ( ) ;  
 	 T i c k s D a t a ( " " ) ;   / /   C o l l e c t   t i c k s   ( i f   n e e d e d )  
 	 T i c k s P e r S e c o n d ( f a l s e ,   t r u e ) ;   / /   C o l l e c t   t i c k s   p e r   s e c o n d  
 	 i f   ( U S E _ V I R T U A L _ S T O P S )   { V i r t u a l S t o p s D r i v e r ( ) ; }  
  
 	 / / i f   ( O r d e r s T o t a l ( ) )   / /   t h i s   m a k e s   t h i n g s   f a s t e r  
 	 / / {  
 	 / / 	 E x p i r a t i o n D r i v e r ( ) ;  
 	 / / 	 O C O D r i v e r ( ) ;   / /   C h e c k   a n d   c l o s e   O C O   o r d e r s  
 	 / / }  
 	 i f   ( E N A B L E _ E V E N T _ T R A D E )   { O n T r a d e L i s t e n e r ( ) ; }  
  
  
 	 / /   s k i p   t i c k s  
 	 i f   ( T i m e L o c a l ( )   <   F X D _ T I C K S K I P _ U N T I L )   { r e t u r n ; }  
  
 	 / / - -   r u n   b l o c k s  
 	 i n t   b l o c k s _ t o _ r u n [ ]   =   { 1 } ;  
 	 f o r   ( i n t   i = 0 ;   i < A r r a y S i z e ( b l o c k s _ t o _ r u n ) ;   i + + )   {  
 	 	 _ b l o c k s _ [ b l o c k s _ t o _ r u n [ i ] ] . r u n ( ) ;  
 	 }  
  
  
 	 r e t u r n ;  
 }  
  
  
  
 / / V V V V V V V V V V V V V V V V V V V V V V V V V V V V V V V V V V V V V V V V V V V V V V V V V V V V V V V V V V V V V V V V V / /  
 / /   T h i s   f u n c t i o n   i s   e x e c u t e d   o n   t r a d e   e v e n t s   -   o p e n ,   c l o s e ,   m o d i f y   / /  
 / / ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ / /  
 v o i d   E v e n t T r a d e ( )  
 {  
  
  
 	 O n T r a d e Q u e u e ( - 1 ) ;  
 }  
  
 / / V V V V V V V V V V V V V V V V V V V V V V V V V V V V V V V V V V V V V V V V V V V V V / /  
 / /   T h i s   f u n c t i o n   i s   e x e c u t e d   o n   a   p e r i o d   b a s i s   / /  
 / / ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ / /  
 v o i d   O n T i m e r ( )  
 {  
 	 / / - -   t o   s i m u l a t e   t i c k s   i n   o f f l i n e   c h a r t s ,   T i m e r   i s   u s e d   i n s t e a d   o f   i n f i n i t e   l o o p  
 	 / / - -   t h e   n e x t   f u n c t i o n   c h e c k s   f o r   c h a n g e s   i n   p r i c e   a n d   c a l l s   O n T i c k ( )   m a n u a l l y  
 	 i f   ( F X D _ C H A R T _ I S _ O F F L I N E   & &   R e f r e s h R a t e s ( ) )   {  
 	 	 O n T i c k ( ) ;  
 	 }  
 	 i f   ( O N _ T R A D E _ R E A L T I M E   = =   1 )   {  
 	 	 O n T r a d e L i s t e n e r ( ) ;  
 	 }  
  
 	 s t a t i c   d a t e t i m e   t 0   =   0 ;  
 	 d a t e t i m e   t   =   0 ;  
 	 b o o l   o k   =   f a l s e ;  
  
 	 i f   ( F X D _ O N T I M E R _ T A K E N )  
 	 {  
 	 	 i f   ( F X D _ O N T I M E R _ T A K E N _ T I M E   >   0 )  
 	 	 {  
 	 	 	 i f   ( F X D _ O N T I M E R _ T A K E N _ I N _ M I L L I S E C O N D S   = =   t r u e )  
 	 	 	 {  
 	 	 	 	 t   =   G e t T i c k C o u n t ( ) ;  
 	 	 	 }  
 	 	 	 e l s e  
 	 	 	 {  
 	 	 	 	 t   =   T i m e L o c a l ( ) ;  
 	 	 	 }  
 	 	 	 i f   ( ( t   -   t 0 )   > =   F X D _ O N T I M E R _ T A K E N _ T I M E )  
 	 	 	 {  
 	 	 	 	 t 0   =   t ;  
 	 	 	 	 o k   =   t r u e ;  
 	 	 	 }  
 	 	 }  
  
 	 	 i f   ( o k   = =   f a l s e )   {  
 	 	 	 r e t u r n ;  
 	 	 }  
 	 }  
  
 }  
  
  
 / / V V V V V V V V V V V V V V V V V V V V V V V V V V V V V V V V V V V V V V V V V V V V V V V V V V V V / /  
 / /   T h i s   f u n c t i o n   i s   e x e c u t e d   w h e n   c h a r t   e v e n t   h a p p e n s   / /  
 / / ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ / /  
 v o i d   O n C h a r t E v e n t (  
 	 c o n s t   i n t   i d ,                   / /   E v e n t   I D  
 	 c o n s t   l o n g &   l p a r a m ,       / /   P a r a m e t e r   o f   t y p e   l o n g   e v e n t  
 	 c o n s t   d o u b l e &   d p a r a m ,   / /   P a r a m e t e r   o f   t y p e   d o u b l e   e v e n t  
 	 c o n s t   s t r i n g &   s p a r a m     / /   P a r a m e t e r   o f   t y p e   s t r i n g   e v e n t s  
 )  
 {  
 	 / / - -   w r i t e   p a r a m e t e r   t o   t h e   s y s t e m   g l o b a l   v a r i a b l e s  
 	 F X D _ O N C H A R T . i d           =   i d ;  
 	 F X D _ O N C H A R T . l p a r a m   =   l p a r a m ;  
 	 F X D _ O N C H A R T . d p a r a m   =   d p a r a m ;  
 	 F X D _ O N C H A R T . s p a r a m   =   s p a r a m ;  
  
  
 	 r e t u r n ;  
 }  
  
 / / V V V V V V V V V V V V V V V V V V V V V V V V V V V V V V V V V V V V V V V V V V V V V V V V V V V V V V / /  
 / /   T h i s   f u n c t i o n   i s   e x e c u t e d   o n c e   w h e n   t h e   p r o g r a m   e n d s   / /  
 / / ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ / /  
 v o i d   O n D e i n i t ( c o n s t   i n t   r e a s o n )  
 {  
 	 i n t   r e s o n   =   U n i n i t i a l i z e R e a s o n ( ) ;  
 	 i f   ( r e s o n   = =   R E A S O N _ C H A R T C H A N G E   | |   r e s o n   = =   R E A S O N _ P A R A M E T E R S   | |   r e a s o n   = =   R E A S O N _ T E M P L A T E )   { r e t u r n ; }  
  
 	 / / - -   i f   T i m e r   w a s   s e t ,   k i l l   i t   h e r e  
 	 E v e n t K i l l T i m e r ( ) ;  
  
 	 i f   ( E N A B L E _ S T A T U S )   D r a w S t a t u s ( " s t o p p e d " ) ;  
 	 i f   ( E N A B L E _ S P R E A D _ M E T E R )   D r a w S p r e a d I n f o ( ) ;  
  
  
  
 	 i f   ( M Q L I n f o I n t e g e r ( M Q L _ T E S T E R ) )   {  
 	 	 P r i n t ( " B a c k t e s t e d   i n   " + D o u b l e T o S t r i n g ( ( G e t T i c k C o u n t ( ) - F X D _ M I L S _ I N I T _ E N D ) / 1 0 0 0 ,   2 ) + "   s e c o n d s " ) ;  
 	 	 d o u b l e   t c   =   G e t T i c k C o u n t ( ) - F X D _ M I L S _ I N I T _ E N D ;  
 	 	 i f   ( t c   >   0 )  
 	 	 {  
 	 	 	 P r i n t ( " A v e r a g e   t i c k s   p e r   s e c o n d :   " + D o u b l e T o S t r i n g ( F X D _ T I C K S _ F R O M _ S T A R T / t c ,   0 ) ) ;  
 	 	 }  
 	 }  
  
 	 i f   ( M Q L I n f o I n t e g e r ( M Q L _ P R O G R A M _ T Y P E )   = =   P R O G R A M _ E X P E R T )  
 	 {  
 	 	 s w i t c h ( U n i n i t i a l i z e R e a s o n ( ) )  
 	 	 {  
 	 	 	 c a s e   R E A S O N _ P R O G R A M           :   P r i n t ( " E x p e r t   A d v i s o r   s e l f   t e r m i n a t e d " ) ;   b r e a k ;  
 	 	 	 c a s e   R E A S O N _ R E M O V E             :   P r i n t ( " E x p e r t   A d v i s o r   r e m o v e d   f r o m   t h e   c h a r t " ) ;   b r e a k ;  
 	 	 	 c a s e   R E A S O N _ R E C O M P I L E       :   P r i n t ( " E x p e r t   A d v i s o r   h a s   b e e n   r e c o m p i l e d " ) ;   b r e a k ;  
 	 	 	 c a s e   R E A S O N _ C H A R T C H A N G E   :   P r i n t ( " S y m b o l   o r   c h a r t   p e r i o d   h a s   b e e n   c h a n g e d " ) ;   b r e a k ;  
 	 	 	 c a s e   R E A S O N _ C H A R T C L O S E     :   P r i n t ( " C h a r t   h a s   b e e n   c l o s e d " ) ;   b r e a k ;  
 	 	 	 c a s e   R E A S O N _ P A R A M E T E R S     :   P r i n t ( " I n p u t   p a r a m e t e r s   h a v e   b e e n   c h a n g e d   b y   a   u s e r " ) ;   b r e a k ;  
 	 	 	 c a s e   R E A S O N _ A C C O U N T           :   P r i n t ( " A n o t h e r   a c c o u n t   h a s   b e e n   a c t i v a t e d   o r   r e c o n n e c t i o n   t o   t h e   t r a d e   s e r v e r   h a s   o c c u r r e d   d u e   t o   c h a n g e s   i n   t h e   a c c o u n t   s e t t i n g s " ) ;   b r e a k ;  
 	 	 	 c a s e   R E A S O N _ T E M P L A T E         :   P r i n t ( " A   n e w   t e m p l a t e   h a s   b e e n   a p p l i e d " ) ;   b r e a k ;  
 	 	 	 c a s e   R E A S O N _ I N I T F A I L E D     :   P r i n t ( " O n I n i t ( )   h a n d l e r   h a s   r e t u r n e d   a   n o n z e r o   v a l u e " ) ;   b r e a k ;  
 	 	 	 c a s e   R E A S O N _ C L O S E               :   P r i n t ( " T e r m i n a l   h a s   b e e n   c l o s e d " ) ;   b r e a k ;  
 	 	 }  
 	 }  
  
 	 / /   d e l e t e   d y n a m i c   p o i n t e r s  
 	 f o r   ( i n t   i = 0 ;   i < A r r a y S i z e ( _ b l o c k s _ ) ;   i + + )  
 	 {  
 	 	 d e l e t e   _ b l o c k s _ [ i ] ;  
 	 	 _ b l o c k s _ [ i ]   =   N U L L ;  
 	 }  
 	 A r r a y R e s i z e ( _ b l o c k s _ ,   0 ) ;  
  
 	 r e t u r n ;  
 }  
  
 / * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * /  
 / /   + - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - +   / /  
 / /   | 	                                                                                   C l a s s e s   o f   b l o c k s                                                                                                         |   / /  
 / /   |                             C l a s s e s   t h a t   c o n t a i n   t h e   a c t u a l   c o d e   o f   t h e   b l o c k s   a n d   t h e i r   i n p u t   p a r a m e t e r s   a s   w e l l                               |   / /  
 / /   + - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - +   / /  
 / * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * /  
  
 / * *  
 	 T h e   b a s e   c l a s s   f o r   a l l   b l o c k   c a l l s  
       * /  
 c l a s s   B l o c k C a l l s  
 {  
 	 p u b l i c :  
 	 	 b o o l   _ _ d i s a b l e d ;   / /   w h e t h e r   o r   n o t   t h e   b l o c k   i s   d i s a b l e d  
  
 	 	 s t r i n g   _ _ b l o c k _ u s e r _ n u m b e r ;  
                 i n t   _ _ b l o c k _ n u m b e r ;  
 	 	 i n t   _ _ b l o c k _ w a i t i n g ;  
 	 	 i n t   _ _ p a r e n t _ n u m b e r ;  
 	 	 i n t   _ _ i n b o u n d _ b l o c k s [ ] ;  
 	 	 i n t   _ _ o u t b o u n d _ b l o c k s [ ] ;  
  
 	 	 v o i d   _ _ a d d I n b o u n d B l o c k ( i n t   i d   =   0 )   {  
 	 	 	 i n t   s i z e   =   A r r a y S i z e ( _ _ i n b o u n d _ b l o c k s ) ;  
 	 	 	 f o r   ( i n t   i   =   0 ;   i   <   s i z e ;   i + + )   {  
 	 	 	 	 i f   ( _ _ i n b o u n d _ b l o c k s [ i ]   = =   i d )   {  
 	 	 	 	 	 r e t u r n ;  
 	 	 	 	 }  
 	 	 	 }  
 	 	 	 A r r a y R e s i z e ( _ _ i n b o u n d _ b l o c k s ,   s i z e   +   1 ) ;  
 	 	 	 _ _ i n b o u n d _ b l o c k s [ s i z e ]   =   i d ;  
 	 	 }  
  
 	 	 v o i d   B l o c k C a l l s ( )   {  
 	 	 	 _ _ d i s a b l e d                     =   f a l s e ;  
 	 	 	 _ _ b l o c k _ u s e r _ n u m b e r   =   " " ;  
 	 	 	 _ _ b l o c k _ n u m b e r             =   0 ;  
 	 	 	 _ _ b l o c k _ w a i t i n g           =   0 ;  
 	 	 	 _ _ p a r e n t _ n u m b e r           =   0 ;  
 	 	 }  
  
 	 	 / * *  
 	 	       A n n o u n c e   t h i s   b l o c k   t o   t h e   l i s t   o f   i n b o u n d   c o n n e c t i o n s   o f   a l l   t h e   b l o c k s   t o   w h i c h   t h i s   b l o c k   i s   c o n n e c t e d   t o  
 	 	       * /  
 	 	 v o i d   _ _ a n n o u n c e T h i s B l o c k ( )  
 	 	 {  
 	 	       / /   a d d   t h e   c u r r e n t   b l o c k   n u m b e r   t o   t h e   l i s t   o f   i n b o u n d   b l o c k s  
 	 	       / /   f o r   e a c h   o u t b o u n d   b l o c k   t h a t   i s   p r o v i d e d  
 	 	 	 f o r   ( i n t   i   =   0 ;   i   <   A r r a y S i z e ( _ _ o u t b o u n d _ b l o c k s ) ;   i + + )  
 	 	 	 {  
 	 	 	 	 i n t   b l o c k   =   _ _ o u t b o u n d _ b l o c k s [ i ] ;   / /   o u t b o u n d   b l o c k   n u m b e r  
 	 	 	 	 i n t   s i z e     =   A r r a y S i z e ( _ b l o c k s _ [ b l o c k ] . _ _ i n b o u n d _ b l o c k s ) ;   / /   t h e   s i z e   o f   i t s   i n b o u n d   l i s t  
  
 	 	 	 	 / /   s k i p   i f   t h e   c u r r e n t   b l o c k   w a s   a l r e a d y   a d d e d  
 	 	 	 	 f o r   ( i n t   j   =   0 ;   j   <   s i z e ;   j + + )   {  
 	 	 	 	 	 i f   ( _ b l o c k s _ [ b l o c k ] . _ _ i n b o u n d _ b l o c k s [ j ]   = =   _ _ b l o c k _ n u m b e r )  
 	 	 	 	 	 {  
 	 	 	 	 	 	 r e t u r n ;  
 	 	 	 	 	 }  
 	 	 	 	 }  
  
 	 	 	 	 / /   a d d   t h e   c u r r e n t   b l o c k   n u m b e r   t o   t h e   l i s t   o f   i n b o u n d   b l o c k s   o f   t h e   o t h e r   b l o c k  
 	 	 	 	 A r r a y R e s i z e ( _ b l o c k s _ [ b l o c k ] . _ _ i n b o u n d _ b l o c k s ,   s i z e   +   1 ) ;  
 	 	 	 	 _ b l o c k s _ [ b l o c k ] . _ _ i n b o u n d _ b l o c k s [ s i z e ]   =   _ _ b l o c k _ n u m b e r ;  
 	 	 	 }  
 	 	 }  
  
 	 	 / /   t h i s   i s   h e r e ,   b e c a u s e   i t   i s   u s e d   i n   t h e   " r u n "   f u n c t i o n  
 	 	 v i r t u a l   v o i d   _ e x e c u t e _ ( )   =   0 ;  
  
 	 	 / * *  
 	 	 	 I n   t h e   d e r i v e d   c l a s s   t h i s   m e t h o d   s h o u l d   b e   u s e d   t o   s e t   d y n a m i c   p a r a m e t e r s   o r   o t h e r   s t u f f   b e f o r e   t h e   m a i n   e x e c u t e .  
 	 	 	 T h i s   m e t h o d   i s   a u t o m a t i c a l l y   c a l l e d   w i t h i n   t h e   m a i n   " r u n "   m e t h o d   b e l o w ,   b e f o r e   t h e   e x e c u t i o n   o f   t h e   m a i n   c l a s s .  
 	 	 	 * /  
 	 	 v i r t u a l   v o i d   _ b e f o r e E x e c u t e _ ( )   { r e t u r n ; } ;  
 	 	 b o o l   _ b e f o r e E x e c u t e E n a b l e d ;   / /   f o r   s p e e d  
  
 	 	 / * *  
 	 	 	 S a m e   a s   _ b e f o r e E x e c u t e _ ,   b u t   t o   w o r k   a f t e r   t h e   e x e c u t e   m e t h o d .  
 	 	 	 * /  
 	 	 v i r t u a l   v o i d   _ a f t e r E x e c u t e _ ( )   { r e t u r n ; } ;  
 	 	 b o o l   _ a f t e r E x e c u t e E n a b l e d ;   / /   f o r   s p e e d  
  
 	 	 / * *  
 	 	 	 T h i s   i s   t h e   m e t h o d   t h a t   i s   u s e d   t o   r u n   t h e   b l o c k  
 	 	 	 * /  
 	 	 v i r t u a l   v o i d   r u n ( i n t   _ p a r e n t _ = 0 )   {  
 	 	 	 _ _ p a r e n t _ n u m b e r   =   _ p a r e n t _ ;  
 	 	 	 i f   ( _ _ d i s a b l e d   | |   F X D _ B R E A K )   { r e t u r n ; }  
 	 	 	 F X D _ C U R R E N T _ F U N C T I O N _ I D   =   _ _ b l o c k _ n u m b e r ;  
  
 	 	 	 i f   ( _ b e f o r e E x e c u t e E n a b l e d )   { _ b e f o r e E x e c u t e _ ( ) ; }  
 	 	 	 _ e x e c u t e _ ( ) ;  
 	 	 	 i f   ( _ a f t e r E x e c u t e E n a b l e d )   { _ a f t e r E x e c u t e _ ( ) ; }  
  
 	 	 	 i f   ( _ _ b l o c k _ w a i t i n g   & &   F X D _ C U R R E N T _ F U N C T I O N _ I D   = =   _ _ b l o c k _ n u m b e r )   { f x d W a i t . A c c u m u l a t e ( F X D _ C U R R E N T _ F U N C T I O N _ I D ) ; }  
 	 	 }  
 } ;  
  
 B l o c k C a l l s   * _ b l o c k s _ [ ] ;  
  
  
 / /   " C h e c k   p r o f i t   ( l a s t   c l o s e d ) "   m o d e l  
 t e m p l a t e < t y p e n a m e   T 1 , t y p e n a m e   T 2 , t y p e n a m e   T 3 , t y p e n a m e   T 4 , t y p e n a m e   T 5 , t y p e n a m e   T 6 , t y p e n a m e   T 7 , t y p e n a m e   T 8 >  
 c l a s s   M D L _ C h e c k L a s t O r d e r P r o f i t :   p u b l i c   B l o c k C a l l s  
 {  
 	 p u b l i c :   / *   I n p u t   P a r a m e t e r s   * /  
 	 T 1   G r o u p M o d e ;  
 	 T 2   G r o u p ;  
 	 T 3   S y m b o l M o d e ;  
 	 T 4   S y m b o l ;  
 	 T 5   B u y s O r S e l l s ;  
 	 T 6   C o m p a r e ;  
 	 T 7   P r o f i t A m o u n t ;  
 	 T 8   O n c e P e r T r a d e ;  
 	 / *   S t a t i c   P a r a m e t e r s   * /  
 	 u l o n g   m e m o r y [ ] ;  
 	 v i r t u a l   v o i d   _ c a l l b a c k _ ( i n t   r )   { r e t u r n ; }  
  
 	 p u b l i c :   / *   C o n s t r u c t o r   * /  
 	 M D L _ C h e c k L a s t O r d e r P r o f i t ( )  
 	 {  
 	 	 G r o u p M o d e   =   ( s t r i n g ) " g r o u p " ;  
 	 	 G r o u p   =   ( s t r i n g ) " " ;  
 	 	 S y m b o l M o d e   =   ( s t r i n g ) " s y m b o l " ;  
 	 	 S y m b o l   =   ( s t r i n g ) C u r r e n t S y m b o l ( ) ;  
 	 	 B u y s O r S e l l s   =   ( s t r i n g ) " b o t h " ;  
 	 	 C o m p a r e   =   ( s t r i n g ) " > " ;  
 	 	 P r o f i t A m o u n t   =   ( d o u b l e ) 0 . 0 ;  
 	 	 O n c e P e r T r a d e   =   ( b o o l ) f a l s e ;  
 	 }  
  
 	 p u b l i c :   / *   T h e   m a i n   m e t h o d   * /  
 	 v i r t u a l   v o i d   _ e x e c u t e _ ( )  
 	 {  
 	 	 d o u b l e   l a s t _ p r o f i t   =   0 ;  
 	 	 i n t   t o t a l                     =   H i s t o r y T r a d e s T o t a l ( ) ;  
 	 	  
 	 	 f o r   ( i n t   i n d e x   =   t o t a l - 1 ;   i n d e x   > =   0 ;   i n d e x - - )  
 	 	 {  
 	 	 	 i f   ( H i s t o r y T r a d e S e l e c t B y I n d e x ( i n d e x ,   G r o u p M o d e ,   G r o u p ,   S y m b o l M o d e ,   S y m b o l ,   B u y s O r S e l l s ) )  
 	 	 	 {  
 	 	 	 	 i f   ( O n c e P e r T r a d e   = =   f a l s e   | |   I n A r r a y ( m e m o r y ,   ( u l o n g ) O r d e r T i c k e t ( ) )   = =   f a l s e )  
 	 	 	 	 {  
 	 	 	 	 	 l a s t _ p r o f i t   =   N o r m a l i z e D o u b l e ( O r d e r P r o f i t ( )   +   O r d e r C o m m i s s i o n ( )   +   O r d e r S w a p ( ) ,   2 ) ;  
 	 	  
 	 	 	 	 	 i f   ( O n c e P e r T r a d e   = =   t r u e )  
 	 	 	 	 	 {  
 	 	 	 	 	 	 A r r a y E n s u r e V a l u e ( m e m o r y ,   ( u l o n g ) O r d e r T i c k e t ( ) ) ;  
 	 	 	 	 	 }  
 	 	  
 	 	 	 	 	 b r e a k ;  
 	 	 	 	 }  
 	 	 	 }  
 	 	 }  
 	 	  
 	 	 i f   ( t o t a l   = =   0   | |   C o m p a r e V a l u e s ( C o m p a r e ,   l a s t _ p r o f i t ,   P r o f i t A m o u n t ) )   { _ c a l l b a c k _ ( 1 ) ; }   e l s e   { _ c a l l b a c k _ ( 0 ) ; }  
 	 }  
 } ;  
  
 / /   " N o   t r a d e "   m o d e l  
 t e m p l a t e < t y p e n a m e   T 1 , t y p e n a m e   T 2 , t y p e n a m e   T 3 , t y p e n a m e   T 4 , t y p e n a m e   T 5 >  
 c l a s s   M D L _ N o O p e n e d O r d e r s :   p u b l i c   B l o c k C a l l s  
 {  
 	 p u b l i c :   / *   I n p u t   P a r a m e t e r s   * /  
 	 T 1   G r o u p M o d e ;  
 	 T 2   G r o u p ;  
 	 T 3   S y m b o l M o d e ;  
 	 T 4   S y m b o l ;  
 	 T 5   B u y s O r S e l l s ;  
 	 v i r t u a l   v o i d   _ c a l l b a c k _ ( i n t   r )   { r e t u r n ; }  
  
 	 p u b l i c :   / *   C o n s t r u c t o r   * /  
 	 M D L _ N o O p e n e d O r d e r s ( )  
 	 {  
 	 	 G r o u p M o d e   =   ( s t r i n g ) " g r o u p " ;  
 	 	 G r o u p   =   ( s t r i n g ) " " ;  
 	 	 S y m b o l M o d e   =   ( s t r i n g ) " s y m b o l " ;  
 	 	 S y m b o l   =   ( s t r i n g ) C u r r e n t S y m b o l ( ) ;  
 	 	 B u y s O r S e l l s   =   ( s t r i n g ) " b o t h " ;  
 	 }  
  
 	 p u b l i c :   / *   T h e   m a i n   m e t h o d   * /  
 	 v i r t u a l   v o i d   _ e x e c u t e _ ( )  
 	 {  
 	 	 b o o l   e x i s t   =   f a l s e ;  
 	 	  
 	 	 f o r   ( i n t   i n d e x   =   T r a d e s T o t a l ( ) - 1 ;   i n d e x   > =   0 ;   i n d e x - - )  
 	 	 {  
 	 	 	 i f   ( T r a d e S e l e c t B y I n d e x ( i n d e x ,   G r o u p M o d e ,   G r o u p ,   S y m b o l M o d e ,   S y m b o l ,   B u y s O r S e l l s ) )  
 	 	 	 {  
 	 	 	 	 e x i s t   =   t r u e ;  
 	 	 	 	 b r e a k ;  
 	 	 	 }  
 	 	 }  
 	 	  
 	 	 i f   ( e x i s t   = =   f a l s e )   { _ c a l l b a c k _ ( 1 ) ; }   e l s e   { _ c a l l b a c k _ ( 0 ) ; }  
 	 }  
 } ;  
  
 / /   " F o r m u l a "   m o d e l  
 t e m p l a t e < t y p e n a m e   T 1 , t y p e n a m e   _ T 1 _ , t y p e n a m e   T 2 , t y p e n a m e   T 3 , t y p e n a m e   _ T 3 _ >  
 c l a s s   M D L _ F o r m u l a _ 1 :   p u b l i c   B l o c k C a l l s  
 {  
 	 p u b l i c :   / *   I n p u t   P a r a m e t e r s   * /  
 	 T 1   L o ;   v i r t u a l   _ T 1 _   _ L o _ ( ) { r e t u r n ( _ T 1 _ ) 0 ; }  
 	 T 2   c o m p a r e ;  
 	 T 3   R o ;   v i r t u a l   _ T 3 _   _ R o _ ( ) { r e t u r n ( _ T 3 _ ) 0 ; }  
 	 v i r t u a l   v o i d   _ c a l l b a c k _ ( i n t   r )   { r e t u r n ; }  
  
 	 p u b l i c :   / *   C o n s t r u c t o r   * /  
 	 M D L _ F o r m u l a _ 1 ( )  
 	 {  
 	 	 c o m p a r e   =   ( s t r i n g ) " + " ;  
 	 }  
  
 	 p u b l i c :   / *   T h e   m a i n   m e t h o d   * /  
 	 v i r t u a l   v o i d   _ e x e c u t e _ ( )  
 	 {  
 	 	 _ T 1 _   l o   =   _ L o _ ( ) ;  
 	 	 i f   ( t y p e n a m e ( _ T 1 _ )   ! =   " s t r i n g "   & &   M a t h A b s ( l o )   = =   E M P T Y _ V A L U E )   { r e t u r n ; }  
 	 	  
 	 	 _ T 3 _   r o   =   _ R o _ ( ) ;  
 	 	 i f   ( t y p e n a m e ( _ T 3 _ )   ! =   " s t r i n g "   & &   M a t h A b s ( r o )   = =   E M P T Y _ V A L U E )   { r e t u r n ; }  
 	 	  
 	 	 v : : t r a d e _ n u m b e r   =   f o r m u l a ( c o m p a r e ,   l o ,   r o ) ;  
 	 	  
 	 	 _ c a l l b a c k _ ( 1 ) ;  
 	 }  
 } ;  
  
 / /   " C o n d i t i o n "   m o d e l  
 t e m p l a t e < t y p e n a m e   T 1 , t y p e n a m e   _ T 1 _ , t y p e n a m e   T 2 , t y p e n a m e   T 3 , t y p e n a m e   _ T 3 _ , t y p e n a m e   T 4 >  
 c l a s s   M D L _ C o n d i t i o n :   p u b l i c   B l o c k C a l l s  
 {  
 	 p u b l i c :   / *   I n p u t   P a r a m e t e r s   * /  
 	 T 1   L o ;   v i r t u a l   _ T 1 _   _ L o _ ( ) { r e t u r n ( _ T 1 _ ) 0 ; }  
 	 T 2   c o m p a r e ;  
 	 T 3   R o ;   v i r t u a l   _ T 3 _   _ R o _ ( ) { r e t u r n ( _ T 3 _ ) 0 ; }  
 	 T 4   c r o s s w i d t h ;  
 	 v i r t u a l   v o i d   _ c a l l b a c k _ ( i n t   r )   { r e t u r n ; }  
  
 	 p u b l i c :   / *   C o n s t r u c t o r   * /  
 	 M D L _ C o n d i t i o n ( )  
 	 {  
 	 	 c o m p a r e   =   ( s t r i n g ) " > " ;  
 	 	 c r o s s w i d t h   =   ( i n t ) 1 ;  
 	 }  
  
 	 p u b l i c :   / *   T h e   m a i n   m e t h o d   * /  
 	 v i r t u a l   v o i d   _ e x e c u t e _ ( )  
 	 {  
 	 	 b o o l   o u t p u t 1   =   f a l s e ,   o u t p u t 2   =   f a l s e ;   / /   o u t p u t   1   a n d   o u t p u t   2  
 	 	 i n t   c r o s s o v e r   =   0 ;  
 	 	  
 	 	 i f   ( c o m p a r e   = =   " x > "   | |   c o m p a r e   = =   " x < " )   { c r o s s o v e r   =   1 ; }  
 	 	  
 	 	 f o r   ( i n t   i   =   0 ;   i   < =   c r o s s o v e r ;   i + + )  
 	 	 {  
 	 	 	 / /   i = 0   -   n o r m a l   p a s s ,   i = 1   -   c r o s s o v e r   p a s s  
 	 	  
 	 	 	 / /   L e f t   o p e r a n d   o f   t h e   c o n d i t i o n  
 	 	 	 F X D _ M O R E _ S H I F T   =   i   *   c r o s s w i d t h ;  
 	 	 	 _ T 1 _   l o   =   _ L o _ ( ) ;  
 	 	 	 i f   ( M a t h A b s ( l o )   = =   E M P T Y _ V A L U E )   { r e t u r n ; }  
 	 	  
 	 	 	 / /   R i g h t   o p e r a n d   o f   t h e   c o n d i t i o n  
 	 	 	 F X D _ M O R E _ S H I F T   =   i   *   c r o s s w i d t h ;  
 	 	 	 _ T 3 _   r o   =   _ R o _ ( ) ;  
 	 	 	 i f   ( M a t h A b s ( r o )   = =   E M P T Y _ V A L U E )   { r e t u r n ; }  
 	 	  
 	 	 	 / /   C o n d i t i o n s  
 	 	 	 i f   ( C o m p a r e V a l u e s ( c o m p a r e ,   l o ,   r o ) )  
 	 	 	 {  
 	 	 	 	 i f   ( i   = =   0 )  
 	 	 	 	 {  
 	 	 	 	 	 o u t p u t 1   =   t r u e ;  
 	 	 	 	 }  
 	 	 	 }  
 	 	 	 e l s e  
 	 	 	 {  
 	 	 	 	 i f   ( i   = =   0 )  
 	 	 	 	 {  
 	 	 	 	 	 o u t p u t 2   =   t r u e ;  
 	 	 	 	 }  
 	 	 	 	 e l s e  
 	 	 	 	 {  
 	 	 	 	 	 o u t p u t 2   =   f a l s e ;  
 	 	 	 	 }  
 	 	 	 }  
 	 	  
 	 	 	 i f   ( c r o s s o v e r   = =   1 )  
 	 	 	 {  
 	 	 	 	 i f   ( C o m p a r e V a l u e s ( c o m p a r e ,   r o ,   l o ) )  
 	 	 	 	 {  
 	 	 	 	 	 i f   ( i   = =   0 )  
 	 	 	 	 	 {  
 	 	 	 	 	 	 o u t p u t 2   =   t r u e ;  
 	 	 	 	 	 }  
 	 	 	 	 }  
 	 	 	 	 e l s e  
 	 	 	 	 {  
 	 	 	 	 	 i f   ( i   = =   1 )  
 	 	 	 	 	 {  
 	 	 	 	 	 	 o u t p u t 1   =   f a l s e ;  
 	 	 	 	 	 }  
 	 	 	 	 }  
 	 	 	 }  
 	 	 }  
 	 	  
 	 	 F X D _ M O R E _ S H I F T   =   0 ;   / /   r e s e t  
 	 	  
 	 	 	     i f   ( o u t p u t 1   = =   t r u e )   { _ c a l l b a c k _ ( 1 ) ; }  
 	 	 e l s e   i f   ( o u t p u t 2   = =   t r u e )   { _ c a l l b a c k _ ( 0 ) ; }  
 	 }  
 } ;  
  
 / /   " M o d i f y   V a r i a b l e s "   m o d e l  
 t e m p l a t e < t y p e n a m e   T 1 , t y p e n a m e   T 2 , t y p e n a m e   _ T 2 _ , t y p e n a m e   T 3 , t y p e n a m e   T 4 , t y p e n a m e   _ T 4 _ , t y p e n a m e   T 5 , t y p e n a m e   T 6 , t y p e n a m e   _ T 6 _ , t y p e n a m e   T 7 , t y p e n a m e   T 8 , t y p e n a m e   _ T 8 _ , t y p e n a m e   T 9 , t y p e n a m e   T 1 0 , t y p e n a m e   _ T 1 0 _ >  
 c l a s s   M D L _ M o d i f y V a r i a b l e s :   p u b l i c   B l o c k C a l l s  
 {  
 	 p u b l i c :   / *   I n p u t   P a r a m e t e r s   * /  
 	 T 1   V a r i a b l e 1 ;  
 	 T 2   V a l u e 1 ;   v i r t u a l   _ T 2 _   _ V a l u e 1 _ ( ) { r e t u r n ( _ T 2 _ ) 0 ; }  
 	 T 3   V a r i a b l e 2 ;  
 	 T 4   V a l u e 2 ;   v i r t u a l   _ T 4 _   _ V a l u e 2 _ ( ) { r e t u r n ( _ T 4 _ ) 0 ; }  
 	 T 5   V a r i a b l e 3 ;  
 	 T 6   V a l u e 3 ;   v i r t u a l   _ T 6 _   _ V a l u e 3 _ ( ) { r e t u r n ( _ T 6 _ ) 0 ; }  
 	 T 7   V a r i a b l e 4 ;  
 	 T 8   V a l u e 4 ;   v i r t u a l   _ T 8 _   _ V a l u e 4 _ ( ) { r e t u r n ( _ T 8 _ ) 0 ; }  
 	 T 9   V a r i a b l e 5 ;  
 	 T 1 0   V a l u e 5 ;   v i r t u a l   _ T 1 0 _   _ V a l u e 5 _ ( ) { r e t u r n ( _ T 1 0 _ ) 0 ; }  
 	 v i r t u a l   v o i d   _ c a l l b a c k _ ( i n t   r )   { r e t u r n ; }  
  
 	 p u b l i c :   / *   C o n s t r u c t o r   * /  
 	 M D L _ M o d i f y V a r i a b l e s ( )  
 	 {  
 	 	 V a r i a b l e 1   =   ( i n t ) 0 ;  
 	 	 V a r i a b l e 2   =   ( i n t ) 0 ;  
 	 	 V a r i a b l e 3   =   ( i n t ) 0 ;  
 	 	 V a r i a b l e 4   =   ( i n t ) 0 ;  
 	 	 V a r i a b l e 5   =   ( i n t ) 0 ;  
 	 }  
  
 	 p u b l i c :   / *   T h e   m a i n   m e t h o d   * /  
 	 v i r t u a l   v o i d   _ e x e c u t e _ ( )  
 	 {  
 	 	 / /   n o t h i n g   h e r e ,   b e c a u s e   t h e   a c t u a l   c o d e   i s   g e n e r a t e d   i n   t h e   g e n e r a t o r  
 	 	 / /   _ V a l u e 1 _ ( )  
 	 	 / /   _ V a l u e 2 _ ( )  
 	 	 / /   _ V a l u e 3 _ ( )  
 	 	 / /   _ V a l u e 4 _ ( )  
 	 	 / /   _ V a l u e 5 _ ( )  
 	 	 _ c a l l b a c k _ ( 1 ) ;  
 	 }  
 } ;  
  
 / /   " B u y   n o w "   m o d e l  
 t e m p l a t e < t y p e n a m e   T 1 , t y p e n a m e   T 2 , t y p e n a m e   T 3 , t y p e n a m e   T 4 , t y p e n a m e   T 5 , t y p e n a m e   T 6 , t y p e n a m e   T 7 , t y p e n a m e   T 8 , t y p e n a m e   T 9 , t y p e n a m e   _ T 9 _ , t y p e n a m e   T 1 0 , t y p e n a m e   T 1 1 , t y p e n a m e   T 1 2 , t y p e n a m e   T 1 3 , t y p e n a m e   T 1 4 , t y p e n a m e   T 1 5 , t y p e n a m e   T 1 6 , t y p e n a m e   T 1 7 , t y p e n a m e   T 1 8 , t y p e n a m e   T 1 9 , t y p e n a m e   T 2 0 , t y p e n a m e   T 2 1 , t y p e n a m e   T 2 2 , t y p e n a m e   T 2 3 , t y p e n a m e   T 2 4 , t y p e n a m e   T 2 5 , t y p e n a m e   T 2 6 , t y p e n a m e   T 2 7 , t y p e n a m e   T 2 8 , t y p e n a m e   T 2 9 , t y p e n a m e   T 3 0 , t y p e n a m e   T 3 1 , t y p e n a m e   T 3 2 , t y p e n a m e   T 3 3 , t y p e n a m e   T 3 4 , t y p e n a m e   T 3 5 , t y p e n a m e   T 3 6 , t y p e n a m e   _ T 3 6 _ , t y p e n a m e   T 3 7 , t y p e n a m e   _ T 3 7 _ , t y p e n a m e   T 3 8 , t y p e n a m e   _ T 3 8 _ , t y p e n a m e   T 3 9 , t y p e n a m e   T 4 0 , t y p e n a m e   T 4 1 , t y p e n a m e   T 4 2 , t y p e n a m e   T 4 3 , t y p e n a m e   _ T 4 3 _ , t y p e n a m e   T 4 4 , t y p e n a m e   _ T 4 4 _ , t y p e n a m e   T 4 5 , t y p e n a m e   _ T 4 5 _ , t y p e n a m e   T 4 6 , t y p e n a m e   T 4 7 , t y p e n a m e   T 4 8 , t y p e n a m e   T 4 9 , t y p e n a m e   T 5 0 , t y p e n a m e   _ T 5 0 _ , t y p e n a m e   T 5 1 , t y p e n a m e   T 5 2 , t y p e n a m e   T 5 3 >  
 c l a s s   M D L _ B u y N o w :   p u b l i c   B l o c k C a l l s  
 {  
 	 p u b l i c :   / *   I n p u t   P a r a m e t e r s   * /  
 	 T 1   G r o u p ;  
 	 T 2   S y m b o l ;  
 	 T 3   V o l u m e M o d e ;  
 	 T 4   V o l u m e S i z e ;  
 	 T 5   V o l u m e S i z e R i s k ;  
 	 T 6   V o l u m e R i s k ;  
 	 T 7   V o l u m e P e r c e n t ;  
 	 T 8   V o l u m e B l o c k P e r c e n t ;  
 	 T 9   d V o l u m e S i z e ;   v i r t u a l   _ T 9 _   _ d V o l u m e S i z e _ ( ) { r e t u r n ( _ T 9 _ ) 0 ; }  
 	 T 1 0   F i x e d R a t i o U n i t S i z e ;  
 	 T 1 1   F i x e d R a t i o D e l t a ;  
 	 T 1 2   m m M g I n i t i a l L o t s ;  
 	 T 1 3   m m M g M u l t i p l y O n L o s s ;  
 	 T 1 4   m m M g M u l t i p l y O n P r o f i t ;  
 	 T 1 5   m m M g A d d L o t s O n L o s s ;  
 	 T 1 6   m m M g A d d L o t s O n P r o f i t ;  
 	 T 1 7   m m M g R e s e t O n L o s s ;  
 	 T 1 8   m m M g R e s e t O n P r o f i t ;  
 	 T 1 9   m m 1 3 2 6 I n i t i a l L o t s ;  
 	 T 2 0   m m 1 3 2 6 R e v e r s e ;  
 	 T 2 1   m m F i b o I n i t i a l L o t s ;  
 	 T 2 2   m m D a l e m b e r t I n i t i a l L o t s ;  
 	 T 2 3   m m D a l e m b e r t R e v e r s e ;  
 	 T 2 4   m m L a b o u c h e r e I n i t i a l L o t s ;  
 	 T 2 5   m m L a b o u c h e r e L i s t ;  
 	 T 2 6   m m L a b o u c h e r e R e v e r s e ;  
 	 T 2 7   m m S e q B a s e L o t s ;  
 	 T 2 8   m m S e q O n L o s s ;  
 	 T 2 9   m m S e q O n P r o f i t ;  
 	 T 3 0   m m S e q R e v e r s e ;  
 	 T 3 1   V o l u m e U p p e r L i m i t ;  
 	 T 3 2   S t o p L o s s M o d e ;  
 	 T 3 3   S t o p L o s s P i p s ;  
 	 T 3 4   S t o p L o s s P e r c e n t P r i c e ;  
 	 T 3 5   S t o p L o s s P e r c e n t T P ;  
 	 T 3 6   d l S t o p L o s s ;   v i r t u a l   _ T 3 6 _   _ d l S t o p L o s s _ ( ) { r e t u r n ( _ T 3 6 _ ) 0 ; }  
 	 T 3 7   d p S t o p L o s s ;   v i r t u a l   _ T 3 7 _   _ d p S t o p L o s s _ ( ) { r e t u r n ( _ T 3 7 _ ) 0 ; }  
 	 T 3 8   d d S t o p L o s s ;   v i r t u a l   _ T 3 8 _   _ d d S t o p L o s s _ ( ) { r e t u r n ( _ T 3 8 _ ) 0 ; }  
 	 T 3 9   T a k e P r o f i t M o d e ;  
 	 T 4 0   T a k e P r o f i t P i p s ;  
 	 T 4 1   T a k e P r o f i t P e r c e n t P r i c e ;  
 	 T 4 2   T a k e P r o f i t P e r c e n t S L ;  
 	 T 4 3   d l T a k e P r o f i t ;   v i r t u a l   _ T 4 3 _   _ d l T a k e P r o f i t _ ( ) { r e t u r n ( _ T 4 3 _ ) 0 ; }  
 	 T 4 4   d p T a k e P r o f i t ;   v i r t u a l   _ T 4 4 _   _ d p T a k e P r o f i t _ ( ) { r e t u r n ( _ T 4 4 _ ) 0 ; }  
 	 T 4 5   d d T a k e P r o f i t ;   v i r t u a l   _ T 4 5 _   _ d d T a k e P r o f i t _ ( ) { r e t u r n ( _ T 4 5 _ ) 0 ; }  
 	 T 4 6   E x p M o d e ;  
 	 T 4 7   E x p D a y s ;  
 	 T 4 8   E x p H o u r s ;  
 	 T 4 9   E x p M i n u t e s ;  
 	 T 5 0   d E x p ;   v i r t u a l   _ T 5 0 _   _ d E x p _ ( ) { r e t u r n ( _ T 5 0 _ ) 0 ; }  
 	 T 5 1   S l i p p a g e ;  
 	 T 5 2   M y C o m m e n t ;  
 	 T 5 3   A r r o w C o l o r B u y ;  
 	 v i r t u a l   v o i d   _ c a l l b a c k _ ( i n t   r )   { r e t u r n ; }  
  
 	 p u b l i c :   / *   C o n s t r u c t o r   * /  
 	 M D L _ B u y N o w ( )  
 	 {  
 	 	 G r o u p   =   ( s t r i n g ) " " ;  
 	 	 S y m b o l   =   ( s t r i n g ) C u r r e n t S y m b o l ( ) ;  
 	 	 V o l u m e M o d e   =   ( s t r i n g ) " f i x e d " ;  
 	 	 V o l u m e S i z e   =   ( d o u b l e ) 0 . 1 ;  
 	 	 V o l u m e S i z e R i s k   =   ( d o u b l e ) 5 0 . 0 ;  
 	 	 V o l u m e R i s k   =   ( d o u b l e ) 2 . 5 ;  
 	 	 V o l u m e P e r c e n t   =   ( d o u b l e ) 1 0 0 . 0 ;  
 	 	 V o l u m e B l o c k P e r c e n t   =   ( d o u b l e ) 3 . 0 ;  
 	 	 F i x e d R a t i o U n i t S i z e   =   ( d o u b l e ) 0 . 0 1 ;  
 	 	 F i x e d R a t i o D e l t a   =   ( d o u b l e ) 2 0 . 0 ;  
 	 	 m m M g I n i t i a l L o t s   =   ( d o u b l e ) 0 . 1 ;  
 	 	 m m M g M u l t i p l y O n L o s s   =   ( d o u b l e ) 2 . 0 ;  
 	 	 m m M g M u l t i p l y O n P r o f i t   =   ( d o u b l e ) 1 . 0 ;  
 	 	 m m M g A d d L o t s O n L o s s   =   ( d o u b l e ) 0 . 0 ;  
 	 	 m m M g A d d L o t s O n P r o f i t   =   ( d o u b l e ) 0 . 0 ;  
 	 	 m m M g R e s e t O n L o s s   =   ( i n t ) 0 ;  
 	 	 m m M g R e s e t O n P r o f i t   =   ( i n t ) 1 ;  
 	 	 m m 1 3 2 6 I n i t i a l L o t s   =   ( d o u b l e ) 0 . 1 ;  
 	 	 m m 1 3 2 6 R e v e r s e   =   ( b o o l ) f a l s e ;  
 	 	 m m F i b o I n i t i a l L o t s   =   ( d o u b l e ) 0 . 1 ;  
 	 	 m m D a l e m b e r t I n i t i a l L o t s   =   ( d o u b l e ) 0 . 1 ;  
 	 	 m m D a l e m b e r t R e v e r s e   =   ( b o o l ) f a l s e ;  
 	 	 m m L a b o u c h e r e I n i t i a l L o t s   =   ( d o u b l e ) 0 . 1 ;  
 	 	 m m L a b o u c h e r e L i s t   =   ( s t r i n g ) " 1 , 2 , 3 , 4 , 5 , 6 " ;  
 	 	 m m L a b o u c h e r e R e v e r s e   =   ( b o o l ) f a l s e ;  
 	 	 m m S e q B a s e L o t s   =   ( d o u b l e ) 0 . 1 ;  
 	 	 m m S e q O n L o s s   =   ( s t r i n g ) " 3 , 2 , 6 " ;  
 	 	 m m S e q O n P r o f i t   =   ( s t r i n g ) " 1 " ;  
 	 	 m m S e q R e v e r s e   =   ( b o o l ) f a l s e ;  
 	 	 V o l u m e U p p e r L i m i t   =   ( d o u b l e ) 0 . 0 ;  
 	 	 S t o p L o s s M o d e   =   ( s t r i n g ) " f i x e d " ;  
 	 	 S t o p L o s s P i p s   =   ( d o u b l e ) 5 0 . 0 ;  
 	 	 S t o p L o s s P e r c e n t P r i c e   =   ( d o u b l e ) 0 . 5 5 ;  
 	 	 S t o p L o s s P e r c e n t T P   =   ( d o u b l e ) 1 0 0 . 0 ;  
 	 	 T a k e P r o f i t M o d e   =   ( s t r i n g ) " f i x e d " ;  
 	 	 T a k e P r o f i t P i p s   =   ( d o u b l e ) 5 0 . 0 ;  
 	 	 T a k e P r o f i t P e r c e n t P r i c e   =   ( d o u b l e ) 0 . 5 5 ;  
 	 	 T a k e P r o f i t P e r c e n t S L   =   ( d o u b l e ) 1 0 0 . 0 ;  
 	 	 E x p M o d e   =   ( s t r i n g ) " G T C " ;  
 	 	 E x p D a y s   =   ( i n t ) 0 ;  
 	 	 E x p H o u r s   =   ( i n t ) 1 ;  
 	 	 E x p M i n u t e s   =   ( i n t ) 0 ;  
 	 	 S l i p p a g e   =   ( u l o n g ) 4 ;  
 	 	 M y C o m m e n t   =   ( s t r i n g ) " " ;  
 	 	 A r r o w C o l o r B u y   =   ( c o l o r ) c l r B l u e ;  
 	 }  
  
 	 p u b l i c :   / *   T h e   m a i n   m e t h o d   * /  
 	 v i r t u a l   v o i d   _ e x e c u t e _ ( )  
 	 {  
 	 	 / / - -   s t o p s   - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  
 	 	 d o u b l e   s l l   =   0 ,   s l p   =   0 ,   t p l   =   0 ,   t p p   =   0 ;  
 	 	  
 	 	           i f   ( S t o p L o s s M o d e   = =   " f i x e d " )                   { s l p   =   S t o p L o s s P i p s ; }  
 	 	 e l s e   i f   ( S t o p L o s s M o d e   = =   " d y n a m i c P i p s " )       { s l p   =   _ d p S t o p L o s s _ ( ) ; }  
 	 	 e l s e   i f   ( S t o p L o s s M o d e   = =   " d y n a m i c D i g i t s " )   { s l p   =   t o P i p s ( _ d d S t o p L o s s _ ( ) , S y m b o l ) ; }  
 	 	 e l s e   i f   ( S t o p L o s s M o d e   = =   " d y n a m i c L e v e l " )     { s l l   =   _ d l S t o p L o s s _ ( ) ; }  
 	 	 e l s e   i f   ( S t o p L o s s M o d e   = =   " p e r c e n t P r i c e " )     { s l l   =   S y m b o l A s k ( S y m b o l )   -   ( S y m b o l A s k ( S y m b o l )   *   S t o p L o s s P e r c e n t P r i c e   /   1 0 0 ) ; }  
 	 	  
 	 	           i f   ( T a k e P r o f i t M o d e   = =   " f i x e d " )                   { t p p   =   T a k e P r o f i t P i p s ; }  
 	 	 e l s e   i f   ( T a k e P r o f i t M o d e   = =   " d y n a m i c P i p s " )       { t p p   =   _ d p T a k e P r o f i t _ ( ) ; }  
 	 	 e l s e   i f   ( T a k e P r o f i t M o d e   = =   " d y n a m i c D i g i t s " )   { t p p   =   t o P i p s ( _ d d T a k e P r o f i t _ ( ) , S y m b o l ) ; }  
 	 	 e l s e   i f   ( T a k e P r o f i t M o d e   = =   " d y n a m i c L e v e l " )     { t p l   =   _ d l T a k e P r o f i t _ ( ) ; }  
 	 	 e l s e   i f   ( T a k e P r o f i t M o d e   = =   " p e r c e n t P r i c e " )     { t p l   =   S y m b o l A s k ( S y m b o l )   +   ( S y m b o l A s k ( S y m b o l )   *   T a k e P r o f i t P e r c e n t P r i c e   /   1 0 0 ) ; }  
 	 	  
 	 	 i f   ( S t o p L o s s M o d e   = =   " p e r c e n t T P " )   {  
 	 	       i f   ( t p p   >   0 )   { s l p   =   t p p * S t o p L o s s P e r c e n t T P / 1 0 0 ; }  
 	 	       i f   ( t p l   >   0 )   { s l p   =   t o P i p s ( M a t h A b s ( S y m b o l A s k ( S y m b o l )   -   t p l ) ,   S y m b o l ) * S t o p L o s s P e r c e n t T P / 1 0 0 ; }  
 	 	 }  
 	 	 i f   ( T a k e P r o f i t M o d e   = =   " p e r c e n t S L " )   {  
 	 	       i f   ( s l p   >   0 )   { t p p   =   s l p * T a k e P r o f i t P e r c e n t S L / 1 0 0 ; }  
 	 	       i f   ( s l l   >   0 )   { t p p   =   t o P i p s ( M a t h A b s ( S y m b o l A s k ( S y m b o l )   -   s l l ) ,   S y m b o l ) * T a k e P r o f i t P e r c e n t S L / 1 0 0 ; }  
 	 	 }  
 	 	  
 	 	 / / - -   l o t s   - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  
 	 	 d o u b l e   l o t s   =   0 ;  
 	 	 d o u b l e   p r e _ s l l   =   s l l ;  
 	 	  
 	 	 i f   ( p r e _ s l l   = =   0 )   {  
 	 	 	 p r e _ s l l   =   S y m b o l A s k ( S y m b o l ) ;  
 	 	 }  
 	 	  
 	 	 d o u b l e   p r e _ s l _ p i p s   =   t o P i p s ( S y m b o l A s k ( S y m b o l ) - ( p r e _ s l l - t o D i g i t s ( s l p , S y m b o l ) ) ,   S y m b o l ) ;  
 	 	  
 	 	           i f   ( V o l u m e M o d e   = =   " f i x e d " )                         { l o t s   =   D y n a m i c L o t s ( S y m b o l ,   V o l u m e M o d e ,   V o l u m e S i z e ) ; }  
 	 	 e l s e   i f   ( V o l u m e M o d e   = =   " b l o c k - e q u i t y " )           { l o t s   =   D y n a m i c L o t s ( S y m b o l ,   V o l u m e M o d e ,   V o l u m e B l o c k P e r c e n t ) ; }  
 	 	 e l s e   i f   ( V o l u m e M o d e   = =   " b l o c k - b a l a n c e " )         { l o t s   =   D y n a m i c L o t s ( S y m b o l ,   V o l u m e M o d e ,   V o l u m e B l o c k P e r c e n t ) ; }  
 	 	 e l s e   i f   ( V o l u m e M o d e   = =   " b l o c k - f r e e m a r g i n " )   { l o t s   =   D y n a m i c L o t s ( S y m b o l ,   V o l u m e M o d e ,   V o l u m e B l o c k P e r c e n t ) ; }  
 	 	 e l s e   i f   ( V o l u m e M o d e   = =   " e q u i t y " )                       { l o t s   =   D y n a m i c L o t s ( S y m b o l ,   V o l u m e M o d e ,   V o l u m e P e r c e n t ) ; }  
 	 	 e l s e   i f   ( V o l u m e M o d e   = =   " b a l a n c e " )                     { l o t s   =   D y n a m i c L o t s ( S y m b o l ,   V o l u m e M o d e ,   V o l u m e P e r c e n t ) ; }  
 	 	 e l s e   i f   ( V o l u m e M o d e   = =   " f r e e m a r g i n " )               { l o t s   =   D y n a m i c L o t s ( S y m b o l ,   V o l u m e M o d e ,   V o l u m e P e r c e n t ) ; }  
 	 	 e l s e   i f   ( V o l u m e M o d e   = =   " e q u i t y R i s k " )               { l o t s   =   D y n a m i c L o t s ( S y m b o l ,   V o l u m e M o d e ,   V o l u m e R i s k ,   p r e _ s l _ p i p s ) ; }  
 	 	 e l s e   i f   ( V o l u m e M o d e   = =   " b a l a n c e R i s k " )             { l o t s   =   D y n a m i c L o t s ( S y m b o l ,   V o l u m e M o d e ,   V o l u m e R i s k ,   p r e _ s l _ p i p s ) ; }  
 	 	 e l s e   i f   ( V o l u m e M o d e   = =   " f r e e m a r g i n R i s k " )       { l o t s   =   D y n a m i c L o t s ( S y m b o l ,   V o l u m e M o d e ,   V o l u m e R i s k ,   p r e _ s l _ p i p s ) ; }  
 	 	 e l s e   i f   ( V o l u m e M o d e   = =   " f i x e d R i s k " )                 { l o t s   =   D y n a m i c L o t s ( S y m b o l ,   V o l u m e M o d e ,   V o l u m e S i z e R i s k ,   p r e _ s l _ p i p s ) ; }  
 	 	 e l s e   i f   ( V o l u m e M o d e   = =   " f i x e d R a t i o " )               { l o t s   =   D y n a m i c L o t s ( S y m b o l ,   V o l u m e M o d e ,   F i x e d R a t i o U n i t S i z e ,   F i x e d R a t i o D e l t a ) ; }  
 	 	 e l s e   i f   ( V o l u m e M o d e   = =   " d y n a m i c " )                     { l o t s   =   _ d V o l u m e S i z e _ ( ) ; }  
 	 	 e l s e   i f   ( V o l u m e M o d e   = =   " 1 3 2 6 " )                           { l o t s   =   B e t 1 3 2 6 ( ( i n t ) G r o u p ,   S y m b o l ,   m m 1 3 2 6 I n i t i a l L o t s ,   m m 1 3 2 6 R e v e r s e ) ; }  
 	 	 e l s e   i f   ( V o l u m e M o d e   = =   " f i b o n a c c i " )                 { l o t s   =   B e t F i b o n a c c i ( ( i n t ) G r o u p ,   S y m b o l ,   m m F i b o I n i t i a l L o t s ) ; }  
 	 	 e l s e   i f   ( V o l u m e M o d e   = =   " d a l e m b e r t " )                 { l o t s   =   B e t D a l e m b e r t ( ( i n t ) G r o u p ,   S y m b o l ,   m m D a l e m b e r t I n i t i a l L o t s ,   m m D a l e m b e r t R e v e r s e ) ; }  
 	 	 e l s e   i f   ( V o l u m e M o d e   = =   " l a b o u c h e r e " )               { l o t s   =   B e t L a b o u c h e r e ( ( i n t ) G r o u p ,   S y m b o l ,   m m L a b o u c h e r e I n i t i a l L o t s ,   m m L a b o u c h e r e L i s t ,   m m L a b o u c h e r e R e v e r s e ) ; }  
 	 	 e l s e   i f   ( V o l u m e M o d e   = =   " m a r t i n g a l e " )               { l o t s   =   B e t M a r t i n g a l e ( ( i n t ) G r o u p ,   S y m b o l ,   m m M g I n i t i a l L o t s ,   m m M g M u l t i p l y O n L o s s ,   m m M g M u l t i p l y O n P r o f i t ,   m m M g A d d L o t s O n L o s s ,   m m M g A d d L o t s O n P r o f i t ,   m m M g R e s e t O n L o s s ,   m m M g R e s e t O n P r o f i t ) ; }  
 	 	 e l s e   i f   ( V o l u m e M o d e   = =   " s e q u e n c e " )                   { l o t s   =   B e t S e q u e n c e ( ( i n t ) G r o u p ,   S y m b o l ,   m m S e q B a s e L o t s ,   m m S e q O n L o s s ,   m m S e q O n P r o f i t ,   m m S e q R e v e r s e ) ; }  
 	 	  
 	 	 l o t s   =   A l i g n L o t s ( S y m b o l ,   l o t s ,   0 ,   V o l u m e U p p e r L i m i t ) ;  
 	 	  
 	 	 d a t e t i m e   e x p   =   E x p i r a t i o n T i m e ( E x p M o d e , E x p D a y s , E x p H o u r s , E x p M i n u t e s , _ d E x p _ ( ) ) ;  
 	 	  
 	 	 / / - -   s e n d   - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  
 	 	 l o n g   t i c k e t   =   B u y N o w ( S y m b o l ,   l o t s ,   s l l ,   t p l ,   s l p ,   t p p ,   S l i p p a g e ,   ( M a g i c S t a r t + ( i n t ) G r o u p ) ,   M y C o m m e n t ,   A r r o w C o l o r B u y ,   e x p ) ;  
 	 	  
 	 	 i f   ( t i c k e t   >   0 )   { _ c a l l b a c k _ ( 1 ) ; }   e l s e   { _ c a l l b a c k _ ( 0 ) ; }  
 	 }  
 } ;  
  
 / /   " F o r m u l a "   m o d e l  
 t e m p l a t e < t y p e n a m e   T 1 , t y p e n a m e   _ T 1 _ , t y p e n a m e   T 2 , t y p e n a m e   T 3 , t y p e n a m e   _ T 3 _ >  
 c l a s s   M D L _ F o r m u l a _ 2 :   p u b l i c   B l o c k C a l l s  
 {  
 	 p u b l i c :   / *   I n p u t   P a r a m e t e r s   * /  
 	 T 1   L o ;   v i r t u a l   _ T 1 _   _ L o _ ( ) { r e t u r n ( _ T 1 _ ) 0 ; }  
 	 T 2   c o m p a r e ;  
 	 T 3   R o ;   v i r t u a l   _ T 3 _   _ R o _ ( ) { r e t u r n ( _ T 3 _ ) 0 ; }  
 	 v i r t u a l   v o i d   _ c a l l b a c k _ ( i n t   r )   { r e t u r n ; }  
  
 	 p u b l i c :   / *   C o n s t r u c t o r   * /  
 	 M D L _ F o r m u l a _ 2 ( )  
 	 {  
 	 	 c o m p a r e   =   ( s t r i n g ) " + " ;  
 	 }  
  
 	 p u b l i c :   / *   T h e   m a i n   m e t h o d   * /  
 	 v i r t u a l   v o i d   _ e x e c u t e _ ( )  
 	 {  
 	 	 _ T 1 _   l o   =   _ L o _ ( ) ;  
 	 	 i f   ( t y p e n a m e ( _ T 1 _ )   ! =   " s t r i n g "   & &   M a t h A b s ( l o )   = =   E M P T Y _ V A L U E )   { r e t u r n ; }  
 	 	  
 	 	 _ T 3 _   r o   =   _ R o _ ( ) ;  
 	 	 i f   ( t y p e n a m e ( _ T 3 _ )   ! =   " s t r i n g "   & &   M a t h A b s ( r o )   = =   E M P T Y _ V A L U E )   { r e t u r n ; }  
 	 	  
 	 	 v : : w i n s   =   f o r m u l a ( c o m p a r e ,   l o ,   r o ) ;  
 	 	  
 	 	 _ c a l l b a c k _ ( 1 ) ;  
 	 }  
 } ;  
  
 / /   " F o r m u l a "   m o d e l  
 t e m p l a t e < t y p e n a m e   T 1 , t y p e n a m e   _ T 1 _ , t y p e n a m e   T 2 , t y p e n a m e   T 3 , t y p e n a m e   _ T 3 _ >  
 c l a s s   M D L _ F o r m u l a _ 3 :   p u b l i c   B l o c k C a l l s  
 {  
 	 p u b l i c :   / *   I n p u t   P a r a m e t e r s   * /  
 	 T 1   L o ;   v i r t u a l   _ T 1 _   _ L o _ ( ) { r e t u r n ( _ T 1 _ ) 0 ; }  
 	 T 2   c o m p a r e ;  
 	 T 3   R o ;   v i r t u a l   _ T 3 _   _ R o _ ( ) { r e t u r n ( _ T 3 _ ) 0 ; }  
 	 v i r t u a l   v o i d   _ c a l l b a c k _ ( i n t   r )   { r e t u r n ; }  
  
 	 p u b l i c :   / *   C o n s t r u c t o r   * /  
 	 M D L _ F o r m u l a _ 3 ( )  
 	 {  
 	 	 c o m p a r e   =   ( s t r i n g ) " + " ;  
 	 }  
  
 	 p u b l i c :   / *   T h e   m a i n   m e t h o d   * /  
 	 v i r t u a l   v o i d   _ e x e c u t e _ ( )  
 	 {  
 	 	 _ T 1 _   l o   =   _ L o _ ( ) ;  
 	 	 i f   ( t y p e n a m e ( _ T 1 _ )   ! =   " s t r i n g "   & &   M a t h A b s ( l o )   = =   E M P T Y _ V A L U E )   { r e t u r n ; }  
 	 	  
 	 	 _ T 3 _   r o   =   _ R o _ ( ) ;  
 	 	 i f   ( t y p e n a m e ( _ T 3 _ )   ! =   " s t r i n g "   & &   M a t h A b s ( r o )   = =   E M P T Y _ V A L U E )   { r e t u r n ; }  
 	 	  
 	 	 v : : l o s s e s   =   f o r m u l a ( c o m p a r e ,   l o ,   r o ) ;  
 	 	  
 	 	 _ c a l l b a c k _ ( 1 ) ;  
 	 }  
 } ;  
  
 / /   " F o r m u l a "   m o d e l  
 t e m p l a t e < t y p e n a m e   T 1 , t y p e n a m e   _ T 1 _ , t y p e n a m e   T 2 , t y p e n a m e   T 3 , t y p e n a m e   _ T 3 _ >  
 c l a s s   M D L _ F o r m u l a _ 4 :   p u b l i c   B l o c k C a l l s  
 {  
 	 p u b l i c :   / *   I n p u t   P a r a m e t e r s   * /  
 	 T 1   L o ;   v i r t u a l   _ T 1 _   _ L o _ ( ) { r e t u r n ( _ T 1 _ ) 0 ; }  
 	 T 2   c o m p a r e ;  
 	 T 3   R o ;   v i r t u a l   _ T 3 _   _ R o _ ( ) { r e t u r n ( _ T 3 _ ) 0 ; }  
 	 v i r t u a l   v o i d   _ c a l l b a c k _ ( i n t   r )   { r e t u r n ; }  
  
 	 p u b l i c :   / *   C o n s t r u c t o r   * /  
 	 M D L _ F o r m u l a _ 4 ( )  
 	 {  
 	 	 c o m p a r e   =   ( s t r i n g ) " + " ;  
 	 }  
  
 	 p u b l i c :   / *   T h e   m a i n   m e t h o d   * /  
 	 v i r t u a l   v o i d   _ e x e c u t e _ ( )  
 	 {  
 	 	 _ T 1 _   l o   =   _ L o _ ( ) ;  
 	 	 i f   ( t y p e n a m e ( _ T 1 _ )   ! =   " s t r i n g "   & &   M a t h A b s ( l o )   = =   E M P T Y _ V A L U E )   { r e t u r n ; }  
 	 	  
 	 	 _ T 3 _   r o   =   _ R o _ ( ) ;  
 	 	 i f   ( t y p e n a m e ( _ T 3 _ )   ! =   " s t r i n g "   & &   M a t h A b s ( r o )   = =   E M P T Y _ V A L U E )   { r e t u r n ; }  
 	 	  
 	 	 v : : l o t s   =   f o r m u l a ( c o m p a r e ,   l o ,   r o ) ;  
 	 	  
 	 	 _ c a l l b a c k _ ( 1 ) ;  
 	 }  
 } ;  
  
 / /   " F o r m u l a "   m o d e l  
 t e m p l a t e < t y p e n a m e   T 1 , t y p e n a m e   _ T 1 _ , t y p e n a m e   T 2 , t y p e n a m e   T 3 , t y p e n a m e   _ T 3 _ >  
 c l a s s   M D L _ F o r m u l a _ 5 :   p u b l i c   B l o c k C a l l s  
 {  
 	 p u b l i c :   / *   I n p u t   P a r a m e t e r s   * /  
 	 T 1   L o ;   v i r t u a l   _ T 1 _   _ L o _ ( ) { r e t u r n ( _ T 1 _ ) 0 ; }  
 	 T 2   c o m p a r e ;  
 	 T 3   R o ;   v i r t u a l   _ T 3 _   _ R o _ ( ) { r e t u r n ( _ T 3 _ ) 0 ; }  
 	 v i r t u a l   v o i d   _ c a l l b a c k _ ( i n t   r )   { r e t u r n ; }  
  
 	 p u b l i c :   / *   C o n s t r u c t o r   * /  
 	 M D L _ F o r m u l a _ 5 ( )  
 	 {  
 	 	 c o m p a r e   =   ( s t r i n g ) " + " ;  
 	 }  
  
 	 p u b l i c :   / *   T h e   m a i n   m e t h o d   * /  
 	 v i r t u a l   v o i d   _ e x e c u t e _ ( )  
 	 {  
 	 	 _ T 1 _   l o   =   _ L o _ ( ) ;  
 	 	 i f   ( t y p e n a m e ( _ T 1 _ )   ! =   " s t r i n g "   & &   M a t h A b s ( l o )   = =   E M P T Y _ V A L U E )   { r e t u r n ; }  
 	 	  
 	 	 _ T 3 _   r o   =   _ R o _ ( ) ;  
 	 	 i f   ( t y p e n a m e ( _ T 3 _ )   ! =   " s t r i n g "   & &   M a t h A b s ( r o )   = =   E M P T Y _ V A L U E )   { r e t u r n ; }  
 	 	  
 	 	 v : : l o t s   =   f o r m u l a ( c o m p a r e ,   l o ,   r o ) ;  
 	 	  
 	 	 _ c a l l b a c k _ ( 1 ) ;  
 	 }  
 } ;  
  
  
 / / - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  
  
 / /   " N u m e r i c "   m o d e l  
 c l a s s   M D L I C _ v a l u e _ v a l u e  
 {  
 	 p u b l i c :   / *   I n p u t   P a r a m e t e r s   * /  
 	 d o u b l e   V a l u e ;  
 	 v i r t u a l   v o i d   _ c a l l b a c k _ ( i n t   r )   { r e t u r n ; }  
  
 	 p u b l i c :   / *   C o n s t r u c t o r   * /  
 	 M D L I C _ v a l u e _ v a l u e ( )  
 	 {  
 	 	 V a l u e   =   ( d o u b l e ) 1 . 0 ;  
 	 }  
  
 	 p u b l i c :   / *   T h e   m a i n   m e t h o d   * /  
 	 d o u b l e   _ e x e c u t e _ ( )  
 	 {  
 	 	 r e t u r n   V a l u e ;  
 	 }  
 } ;  
  
 / /   " T i m e "   m o d e l  
 c l a s s   M D L I C _ v a l u e _ t i m e  
 {  
 	 p u b l i c :   / *   I n p u t   P a r a m e t e r s   * /  
 	 i n t   M o d e T i m e ;  
 	 i n t   T i m e S o u r c e ;  
 	 s t r i n g   T i m e S t a m p ;  
 	 i n t   T i m e C a n d l e I D ;  
 	 s t r i n g   T i m e M a r k e t ;  
 	 E N U M _ T I M E F R A M E S   T i m e C a n d l e T i m e f r a m e ;  
 	 i n t   T i m e C o m p o n e n t Y e a r ;  
 	 i n t   T i m e C o m p o n e n t M o n t h ;  
 	 d o u b l e   T i m e C o m p o n e n t D a y ;  
 	 d o u b l e   T i m e C o m p o n e n t H o u r ;  
 	 d o u b l e   T i m e C o m p o n e n t M i n u t e ;  
 	 i n t   T i m e C o m p o n e n t S e c o n d ;  
 	 i n t   M o d e T i m e S h i f t ;  
 	 i n t   T i m e S h i f t Y e a r s ;  
 	 i n t   T i m e S h i f t M o n t h s ;  
 	 i n t   T i m e S h i f t W e e k s ;  
 	 d o u b l e   T i m e S h i f t D a y s ;  
 	 d o u b l e   T i m e S h i f t H o u r s ;  
 	 d o u b l e   T i m e S h i f t M i n u t e s ;  
 	 i n t   T i m e S h i f t S e c o n d s ;  
 	 b o o l   T i m e S k i p W e e k d a y s ;  
 	 / *   S t a t i c   P a r a m e t e r s   * /  
 	 d a t e t i m e   r e t v a l ;  
 	 d a t e t i m e   r e t v a l 0 ;  
 	 i n t   M o d e T i m e 0 ;  
 	 i n t   s m o d e s h i f t ;  
 	 i n t   y e a r s 0 ;  
 	 i n t   m o n t h s 0 ;  
 	 d a t e t i m e   T i m e [ ] ;  
 	 v i r t u a l   v o i d   _ c a l l b a c k _ ( i n t   r )   { r e t u r n ; }  
  
 	 p u b l i c :   / *   C o n s t r u c t o r   * /  
 	 M D L I C _ v a l u e _ t i m e ( )  
 	 {  
 	 	 M o d e T i m e   =   ( i n t ) 0 ;  
 	 	 T i m e S o u r c e   =   ( i n t ) 0 ;  
 	 	 T i m e S t a m p   =   ( s t r i n g ) " 0 0 : 0 0 " ;  
 	 	 T i m e C a n d l e I D   =   ( i n t ) 1 ;  
 	 	 T i m e M a r k e t   =   ( s t r i n g ) " " ;  
 	 	 T i m e C a n d l e T i m e f r a m e   =   ( E N U M _ T I M E F R A M E S ) 0 ;  
 	 	 T i m e C o m p o n e n t Y e a r   =   ( i n t ) 0 ;  
 	 	 T i m e C o m p o n e n t M o n t h   =   ( i n t ) 0 ;  
 	 	 T i m e C o m p o n e n t D a y   =   ( d o u b l e ) 0 . 0 ;  
 	 	 T i m e C o m p o n e n t H o u r   =   ( d o u b l e ) 1 2 . 0 ;  
 	 	 T i m e C o m p o n e n t M i n u t e   =   ( d o u b l e ) 0 . 0 ;  
 	 	 T i m e C o m p o n e n t S e c o n d   =   ( i n t ) 0 ;  
 	 	 M o d e T i m e S h i f t   =   ( i n t ) 0 ;  
 	 	 T i m e S h i f t Y e a r s   =   ( i n t ) 0 ;  
 	 	 T i m e S h i f t M o n t h s   =   ( i n t ) 0 ;  
 	 	 T i m e S h i f t W e e k s   =   ( i n t ) 0 ;  
 	 	 T i m e S h i f t D a y s   =   ( d o u b l e ) 0 . 0 ;  
 	 	 T i m e S h i f t H o u r s   =   ( d o u b l e ) 0 . 0 ;  
 	 	 T i m e S h i f t M i n u t e s   =   ( d o u b l e ) 0 . 0 ;  
 	 	 T i m e S h i f t S e c o n d s   =   ( i n t ) 0 ;  
 	 	 T i m e S k i p W e e k d a y s   =   ( b o o l ) f a l s e ;  
 	 	 / *   S t a t i c   P a r a m e t e r s   ( i n i t i a l   v a l u e )   * /  
 	 	 r e t v a l   =     0 ;  
 	 	 r e t v a l 0   =     0 ;  
 	 	 M o d e T i m e 0   =     0 ;  
 	 	 s m o d e s h i f t   =     0 ;  
 	 	 y e a r s 0   =     0 ;  
 	 	 m o n t h s 0   =     0 ;  
 	 }  
  
 	 p u b l i c :   / *   T h e   m a i n   m e t h o d   * /  
 	 d a t e t i m e   _ e x e c u t e _ ( )  
 	 {  
 	 	 / /   t h i s   i s   s t a t i c   f o r   s p e e d   r e a s o n s  
 	 	  
 	 	 i f   ( T i m e M a r k e t   = =   " " )   T i m e M a r k e t   =   S y m b o l ( ) ;  
 	 	  
 	 	 i f   ( M o d e T i m e   = =   0 )  
 	 	 {  
 	 	 	           i f   ( T i m e S o u r c e   = =   0 )   { r e t v a l   =   T i m e C u r r e n t ( ) ; }  
 	 	 	 e l s e   i f   ( T i m e S o u r c e   = =   1 )   { r e t v a l   =   T i m e L o c a l ( ) ; }  
 	 	 	 e l s e   i f   ( T i m e S o u r c e   = =   2 )   { r e t v a l   =   T i m e G M T ( ) ; }  
 	 	 }  
 	 	 e l s e   i f   ( M o d e T i m e   = =   1 )  
 	 	 {  
 	 	 	 r e t v a l     =   S t r i n g T o T i m e ( T i m e S t a m p ) ;  
 	 	 	 r e t v a l 0   =   r e t v a l ;  
 	 	 }  
 	 	 e l s e   i f   ( M o d e T i m e = = 2 )  
 	 	 {  
 	 	 	 r e t v a l   =   T i m e F r o m C o m p o n e n t s ( T i m e S o u r c e ,   T i m e C o m p o n e n t Y e a r ,   T i m e C o m p o n e n t M o n t h ,   T i m e C o m p o n e n t D a y ,   T i m e C o m p o n e n t H o u r ,   T i m e C o m p o n e n t M i n u t e ,   T i m e C o m p o n e n t S e c o n d ) ;  
 	 	 }  
 	 	 e l s e   i f   ( M o d e T i m e   = =   3 )  
 	 	 {  
 	 	 	 A r r a y S e t A s S e r i e s ( T i m e , t r u e ) ;  
 	 	 	 C o p y T i m e ( T i m e M a r k e t , T i m e C a n d l e T i m e f r a m e , T i m e C a n d l e I D , 1 , T i m e ) ;  
 	 	 	 r e t v a l   =   T i m e [ 0 ] ;  
 	 	 }  
 	 	  
 	 	 i f   ( M o d e T i m e S h i f t   >   0 )  
 	 	 {  
 	 	 	 i n t   s h   =   1 ;  
 	 	  
 	 	 	 i f   ( M o d e T i m e S h i f t   = =   1 )   { s h   =   - 1 ; }  
 	 	  
 	 	 	 i f   (  
 	 	 	 	       M o d e T i m e S h i f t   ! =   s m o d e s h i f t  
 	 	 	 	 | |   T i m e S h i f t Y e a r s   ! =   y e a r s 0  
 	 	 	 	 | |   T i m e S h i f t M o n t h s   ! =   m o n t h s 0  
 	 	 	 )  
 	 	 	 {  
 	 	 	 	 y e a r s 0     =   T i m e S h i f t Y e a r s ;  
 	 	 	 	 m o n t h s 0   =   T i m e S h i f t M o n t h s ;  
 	 	  
 	 	 	 	 i f   ( T i m e S h i f t Y e a r s   >   0   | |   T i m e S h i f t M o n t h s   >   0 )  
 	 	 	 	 {  
 	 	 	 	 	 i n t   y e a r   =   0 ,   m o n t h   =   0 ,   w e e k   =   0 ,   d a y   =   0 ,   h o u r   =   0 ,   m i n u t e   =   0 ,   s e c o n d   =   0 ;  
 	 	  
 	 	 	 	 	 i f   ( M o d e T i m e   = =   3 )  
 	 	 	 	 	 {  
 	 	 	 	 	 	 y e a r       =   T i m e C o m p o n e n t Y e a r ;  
 	 	 	 	 	 	 m o n t h     =   T i m e C o m p o n e n t Y e a r ;  
 	 	 	 	 	 	 d a y         =   ( i n t ) M a t h F l o o r ( T i m e C o m p o n e n t D a y ) ;  
 	 	 	 	 	 	 h o u r       =   ( i n t ) ( M a t h F l o o r ( T i m e C o m p o n e n t H o u r )   +   ( 2 4   *   ( T i m e C o m p o n e n t D a y   -   M a t h F l o o r ( T i m e C o m p o n e n t D a y ) ) ) ) ;  
 	 	 	 	 	 	 m i n u t e   =   ( i n t ) ( M a t h F l o o r ( T i m e C o m p o n e n t M i n u t e )   +   ( 6 0   *   ( T i m e C o m p o n e n t H o u r   -   M a t h F l o o r ( T i m e C o m p o n e n t H o u r ) ) ) ) ;  
 	 	 	 	 	 	 s e c o n d   =   ( i n t ) ( T i m e C o m p o n e n t S e c o n d   +   ( 6 0   *   ( T i m e C o m p o n e n t M i n u t e   -   M a t h F l o o r ( T i m e C o m p o n e n t M i n u t e ) ) ) ) ;  
 	 	 	 	 	 }  
 	 	 	 	 	 e l s e   {  
 	 	 	 	 	 	 y e a r       =   T i m e Y e a r ( r e t v a l ) ;  
 	 	 	 	 	 	 m o n t h     =   T i m e M o n t h ( r e t v a l ) ;  
 	 	 	 	 	 	 d a y         =   T i m e D a y ( r e t v a l ) ;  
 	 	 	 	 	 	 h o u r       =   T i m e H o u r ( r e t v a l ) ;  
 	 	 	 	 	 	 m i n u t e   =   T i m e M i n u t e ( r e t v a l ) ;  
 	 	 	 	 	 	 s e c o n d   =   T i m e S e c o n d s ( r e t v a l ) ;  
 	 	 	 	 	 }  
 	 	  
 	 	 	 	 	 y e a r     =   y e a r   +   T i m e S h i f t Y e a r s   *   s h ;  
 	 	 	 	 	 m o n t h   =   m o n t h   +   T i m e S h i f t M o n t h s   *   s h ;  
 	 	  
 	 	 	 	 	           i f   ( m o n t h   <   0 )   { m o n t h   =   1 2   -   m o n t h ; }  
 	 	 	 	 	 e l s e   i f   ( m o n t h   >   1 2 )   { m o n t h   =   m o n t h   -   1 2 ; }  
 	 	  
 	 	 	 	 	 r e t v a l   =   S t r i n g T o T i m e ( I n t e g e r T o S t r i n g ( y e a r ) + " . " + I n t e g e r T o S t r i n g ( m o n t h ) + " . " + I n t e g e r T o S t r i n g ( d a y ) + "   " + I n t e g e r T o S t r i n g ( h o u r ) + " : " + I n t e g e r T o S t r i n g ( m i n u t e ) + " : " + I n t e g e r T o S t r i n g ( s e c o n d ) ) ;  
 	 	 	 	 }  
 	 	 	 }  
 	 	  
 	 	 	 r e t v a l   =   r e t v a l   +   ( s h   *   ( ( 6 0 4 8 0 0   *   T i m e S h i f t W e e k s )   +   S e c o n d s F r o m C o m p o n e n t s ( T i m e S h i f t D a y s ,   T i m e S h i f t H o u r s ,   T i m e S h i f t M i n u t e s ,   T i m e S h i f t S e c o n d s ) ) ) ;  
 	 	  
 	 	 	 i f   ( T i m e S k i p W e e k d a y s   = =   t r u e )  
 	 	 	 {  
 	 	 	 	 i n t   w e e k d a y   =   T i m e D a y O f W e e k ( r e t v a l ) ;  
 	 	  
 	 	 	 	 i f   ( s h   >   0 )   {   / /   f o r w a r d  
 	 	 	 	 	           i f   ( w e e k d a y   = =   0 )   { r e t v a l   =   r e t v a l   +   8 6 4 0 0 ; }  
 	 	 	 	 	 e l s e   i f   ( w e e k d a y   = =   6 )   { r e t v a l   =   r e t v a l   +   1 7 2 8 0 0 ; }  
 	 	 	 	 }  
 	 	 	 	 e l s e   i f   ( s h   <   0 )   {   / /   b a c k  
 	 	 	 	 	           i f   ( w e e k d a y   = =   0 )   { r e t v a l   =   r e t v a l   -   1 7 2 8 0 0 ; }  
 	 	 	 	 	 e l s e   i f   ( w e e k d a y   = =   6 )   { r e t v a l   =   r e t v a l   -   8 6 4 0 0 ; }  
 	 	 	 	 }  
 	 	 	 }  
 	 	 }  
 	 	  
 	 	 s m o d e s h i f t   =   M o d e T i m e S h i f t ;  
 	 	 M o d e T i m e 0     =   M o d e T i m e ;  
 	 	  
 	 	 r e t u r n   ( d a t e t i m e ) r e t v a l ;  
 	 }  
 } ;  
  
 / /   " E q u i t y "   m o d e l  
 c l a s s   M D L I C _ a c c o u n t _ A c c o u n t E q u i t y  
 {  
 	 p u b l i c :   / *   I n p u t   P a r a m e t e r s   * /  
 	 v i r t u a l   v o i d   _ c a l l b a c k _ ( i n t   r )   { r e t u r n ; }  
  
 	 p u b l i c :   / *   C o n s t r u c t o r   * /  
 	 M D L I C _ a c c o u n t _ A c c o u n t E q u i t y ( )  
 	 {  
 	 }  
  
 	 p u b l i c :   / *   T h e   m a i n   m e t h o d   * /  
 	 d o u b l e   _ e x e c u t e _ ( )  
 	 {  
 	 	 r e t u r n   N o r m a l i z e D o u b l e ( A c c o u n t I n f o D o u b l e ( A C C O U N T _ E Q U I T Y ) ,   2 ) ;  
 	 }  
 } ;  
  
  
 / / - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  
  
 / /   B l o c k   1   ( C h e c k   p r o f i t   ( l a s t   c l o s e d ) )  
 c l a s s   B l o c k 0 :   p u b l i c   M D L _ C h e c k L a s t O r d e r P r o f i t < s t r i n g , s t r i n g , s t r i n g , s t r i n g , s t r i n g , s t r i n g , d o u b l e , b o o l >  
 {  
  
 	 p u b l i c :   / *   C o n s t r u c t o r   * /  
 	 B l o c k 0 ( )   {  
 	 	 _ _ b l o c k _ n u m b e r   =   0 ;  
 	 	 _ _ b l o c k _ u s e r _ n u m b e r   =   " 1 " ;  
 	 	 _ b e f o r e E x e c u t e E n a b l e d   =   t r u e ;  
  
 	 	 / /   F i l l   t h e   l i s t   o f   o u t b o u n d   b l o c k s  
 	 	 i n t   _ _ _ o u t b o u n d _ b l o c k s [ 2 ]   =   { 6 , 7 } ;  
 	 	 A r r a y C o p y ( _ _ o u t b o u n d _ b l o c k s ,   _ _ _ o u t b o u n d _ b l o c k s ) ;  
 	 }  
  
 	 p u b l i c :   / *   C a l l b a c k   &   R u n   * /  
 	 v i r t u a l   v o i d   _ c a l l b a c k _ ( i n t   v a l u e )   {  
 	 	 i f   ( v a l u e   = =   0 )   {  
 	 	 	 _ b l o c k s _ [ 7 ] . r u n ( 0 ) ;  
 	 	 }  
 	 	 e l s e   i f   ( v a l u e   = =   1 )   {  
 	 	 	 _ b l o c k s _ [ 6 ] . r u n ( 0 ) ;  
 	 	 }  
 	 }  
  
 	 v i r t u a l   v o i d   _ b e f o r e E x e c u t e _ ( )  
 	 {  
 	 	 S y m b o l   =   ( s t r i n g ) C u r r e n t S y m b o l ( ) ;  
 	 }  
 } ;  
  
 / /   B l o c k   2   ( N o   t r a d e )  
 c l a s s   B l o c k 1 :   p u b l i c   M D L _ N o O p e n e d O r d e r s < s t r i n g , s t r i n g , s t r i n g , s t r i n g , s t r i n g >  
 {  
  
 	 p u b l i c :   / *   C o n s t r u c t o r   * /  
 	 B l o c k 1 ( )   {  
 	 	 _ _ b l o c k _ n u m b e r   =   1 ;  
 	 	 _ _ b l o c k _ u s e r _ n u m b e r   =   " 2 " ;  
 	 	 _ b e f o r e E x e c u t e E n a b l e d   =   t r u e ;  
  
 	 	 / /   F i l l   t h e   l i s t   o f   o u t b o u n d   b l o c k s  
 	 	 i n t   _ _ _ o u t b o u n d _ b l o c k s [ 1 ]   =   { 0 } ;  
 	 	 A r r a y C o p y ( _ _ o u t b o u n d _ b l o c k s ,   _ _ _ o u t b o u n d _ b l o c k s ) ;  
 	 }  
  
 	 p u b l i c :   / *   C a l l b a c k   &   R u n   * /  
 	 v i r t u a l   v o i d   _ c a l l b a c k _ ( i n t   v a l u e )   {  
 	 	 i f   ( v a l u e   = =   1 )   {  
 	 	 	 _ b l o c k s _ [ 0 ] . r u n ( 1 ) ;  
 	 	 }  
 	 }  
  
 	 v i r t u a l   v o i d   _ b e f o r e E x e c u t e _ ( )  
 	 {  
 	 	 S y m b o l   =   ( s t r i n g ) C u r r e n t S y m b o l ( ) ;  
 	 }  
 } ;  
  
 / /   B l o c k   3   ( F o r m u l a )  
 c l a s s   B l o c k 2 :   p u b l i c   M D L _ F o r m u l a _ 1 < M D L I C _ v a l u e _ v a l u e , d o u b l e , s t r i n g , M D L I C _ v a l u e _ v a l u e , d o u b l e >  
 {  
  
 	 p u b l i c :   / *   C o n s t r u c t o r   * /  
 	 B l o c k 2 ( )   {  
 	 	 _ _ b l o c k _ n u m b e r   =   2 ;  
 	 	 _ _ b l o c k _ u s e r _ n u m b e r   =   " 3 " ;  
  
  
 	 	 / /   F i l l   t h e   l i s t   o f   o u t b o u n d   b l o c k s  
 	 	 i n t   _ _ _ o u t b o u n d _ b l o c k s [ 1 ]   =   { 3 } ;  
 	 	 A r r a y C o p y ( _ _ o u t b o u n d _ b l o c k s ,   _ _ _ o u t b o u n d _ b l o c k s ) ;  
 	 }  
  
 	 p u b l i c :   / *   C u s t o m   m e t h o d s   * /  
 	 v i r t u a l   d o u b l e   _ L o _ ( )   {  
 	 	 L o . V a l u e   =   v : : t r a d e _ n u m b e r ;  
  
 	 	 r e t u r n   L o . _ e x e c u t e _ ( ) ;  
 	 }  
 	 v i r t u a l   d o u b l e   _ R o _ ( )   { r e t u r n   R o . _ e x e c u t e _ ( ) ; }  
  
 	 p u b l i c :   / *   C a l l b a c k   &   R u n   * /  
 	 v i r t u a l   v o i d   _ c a l l b a c k _ ( i n t   v a l u e )   {  
 	 	 i f   ( v a l u e   = =   1 )   {  
 	 	 	 _ b l o c k s _ [ 3 ] . r u n ( 2 ) ;  
 	 	 }  
 	 }  
 } ;  
  
 / /   B l o c k   4   ( C o n d i t i o n )  
 c l a s s   B l o c k 3 :   p u b l i c   M D L _ C o n d i t i o n < M D L I C _ v a l u e _ v a l u e , d o u b l e , s t r i n g , M D L I C _ v a l u e _ v a l u e , d o u b l e , i n t >  
 {  
  
 	 p u b l i c :   / *   C o n s t r u c t o r   * /  
 	 B l o c k 3 ( )   {  
 	 	 _ _ b l o c k _ n u m b e r   =   3 ;  
 	 	 _ _ b l o c k _ u s e r _ n u m b e r   =   " 4 " ;  
  
  
 	 	 / /   F i l l   t h e   l i s t   o f   o u t b o u n d   b l o c k s  
 	 	 i n t   _ _ _ o u t b o u n d _ b l o c k s [ 4 ]   =   { 1 0 , 1 1 , 1 4 , 5 } ;  
 	 	 A r r a y C o p y ( _ _ o u t b o u n d _ b l o c k s ,   _ _ _ o u t b o u n d _ b l o c k s ) ;  
 	 	 / /   B l o c k   i n p u t   p a r a m e t e r s  
 	 	 c o m p a r e   =   " = = " ;  
 	 }  
  
 	 p u b l i c :   / *   C u s t o m   m e t h o d s   * /  
 	 v i r t u a l   d o u b l e   _ L o _ ( )   {  
 	 	 L o . V a l u e   =   v : : t r a d e _ n u m b e r ;  
  
 	 	 r e t u r n   L o . _ e x e c u t e _ ( ) ;  
 	 }  
 	 v i r t u a l   d o u b l e   _ R o _ ( )   {  
 	 	 R o . V a l u e   =   c : : N _ t r a d e s _ p e r _ s e t ;  
  
 	 	 r e t u r n   R o . _ e x e c u t e _ ( ) ;  
 	 }  
  
 	 p u b l i c :   / *   C a l l b a c k   &   R u n   * /  
 	 v i r t u a l   v o i d   _ c a l l b a c k _ ( i n t   v a l u e )   {  
 	 	 i f   ( v a l u e   = =   0 )   {  
 	 	 	 _ b l o c k s _ [ 5 ] . r u n ( 3 ) ;  
 	 	 }  
 	 	 e l s e   i f   ( v a l u e   = =   1 )   {  
 	 	 	 _ b l o c k s _ [ 1 0 ] . r u n ( 3 ) ;  
 	 	 	 _ b l o c k s _ [ 1 1 ] . r u n ( 3 ) ;  
 	 	 	 _ b l o c k s _ [ 1 4 ] . r u n ( 3 ) ;  
 	 	 }  
 	 }  
 } ;  
  
 / /   B l o c k   5   ( M o d i f y   V a r i a b l e s )  
 c l a s s   B l o c k 4 :   p u b l i c   M D L _ M o d i f y V a r i a b l e s < i n t , M D L I C _ v a l u e _ v a l u e , d o u b l e , i n t , M D L I C _ v a l u e _ v a l u e , d o u b l e , i n t , M D L I C _ v a l u e _ v a l u e , d o u b l e , i n t , M D L I C _ v a l u e _ v a l u e , d o u b l e , i n t , M D L I C _ v a l u e _ v a l u e , d o u b l e >  
 {  
  
 	 p u b l i c :   / *   C o n s t r u c t o r   * /  
 	 B l o c k 4 ( )   {  
 	 	 _ _ b l o c k _ n u m b e r   =   4 ;  
 	 	 _ _ b l o c k _ u s e r _ n u m b e r   =   " 5 " ;  
 	 	 _ b e f o r e E x e c u t e E n a b l e d   =   t r u e ;  
  
 	 	 / /   F i l l   t h e   l i s t   o f   o u t b o u n d   b l o c k s  
 	 	 i n t   _ _ _ o u t b o u n d _ b l o c k s [ 1 ]   =   { 5 } ;  
 	 	 A r r a y C o p y ( _ _ o u t b o u n d _ b l o c k s ,   _ _ _ o u t b o u n d _ b l o c k s ) ;  
  
 	 	 / /   I C   i n p u t   p a r a m e t e r s  
 	 	 V a l u e 1 . V a l u e   =   0 . 0 ;  
 	 	 V a l u e 2 . V a l u e   =   0 . 0 ;  
 	 	 V a l u e 3 . V a l u e   =   0 . 0 ;  
 	 }  
  
 	 p u b l i c :   / *   C u s t o m   m e t h o d s   * /  
 	 v i r t u a l   d o u b l e   _ V a l u e 1 _ ( )   { r e t u r n   V a l u e 1 . _ e x e c u t e _ ( ) ; }  
 	 v i r t u a l   d o u b l e   _ V a l u e 2 _ ( )   { r e t u r n   V a l u e 2 . _ e x e c u t e _ ( ) ; }  
 	 v i r t u a l   d o u b l e   _ V a l u e 3 _ ( )   { r e t u r n   V a l u e 3 . _ e x e c u t e _ ( ) ; }  
 	 v i r t u a l   d o u b l e   _ V a l u e 4 _ ( )   { r e t u r n   V a l u e 4 . _ e x e c u t e _ ( ) ; }  
 	 v i r t u a l   d o u b l e   _ V a l u e 5 _ ( )   { r e t u r n   V a l u e 5 . _ e x e c u t e _ ( ) ; }  
  
 	 p u b l i c :   / *   C a l l b a c k   &   R u n   * /  
 	 v i r t u a l   v o i d   _ c a l l b a c k _ ( i n t   v a l u e )   {  
 	 	 i f   ( v a l u e   = =   1 )   {  
 	 	 	 _ b l o c k s _ [ 5 ] . r u n ( 4 ) ;  
 	 	 }  
 	 }  
  
 	 v i r t u a l   v o i d   _ b e f o r e E x e c u t e _ ( )  
 	 {  
 	 	 v : : w i n s   =   _ V a l u e 1 _ ( ) ;  
 	 	 v : : l o s s e s   =   _ V a l u e 2 _ ( ) ;  
 	 	 v : : t r a d e _ n u m b e r   =   _ V a l u e 3 _ ( ) ;  
 	 }  
 } ;  
  
 / /   B l o c k   6   ( B u y   n o w )  
 c l a s s   B l o c k 5 :   p u b l i c   M D L _ B u y N o w < s t r i n g , s t r i n g , s t r i n g , d o u b l e , d o u b l e , d o u b l e , d o u b l e , d o u b l e , M D L I C _ v a l u e _ v a l u e , d o u b l e , d o u b l e , d o u b l e , d o u b l e , d o u b l e , d o u b l e , d o u b l e , d o u b l e , i n t , i n t , d o u b l e , b o o l , d o u b l e , d o u b l e , b o o l , d o u b l e , s t r i n g , b o o l , d o u b l e , s t r i n g , s t r i n g , b o o l , d o u b l e , s t r i n g , d o u b l e , d o u b l e , d o u b l e , M D L I C _ v a l u e _ v a l u e , d o u b l e , M D L I C _ v a l u e _ v a l u e , d o u b l e , M D L I C _ v a l u e _ v a l u e , d o u b l e , s t r i n g , d o u b l e , d o u b l e , d o u b l e , M D L I C _ v a l u e _ v a l u e , d o u b l e , M D L I C _ v a l u e _ v a l u e , d o u b l e , M D L I C _ v a l u e _ v a l u e , d o u b l e , s t r i n g , i n t , i n t , i n t , M D L I C _ v a l u e _ t i m e , d a t e t i m e , u l o n g , s t r i n g , c o l o r >  
 {  
  
 	 p u b l i c :   / *   C o n s t r u c t o r   * /  
 	 B l o c k 5 ( )   {  
 	 	 _ _ b l o c k _ n u m b e r   =   5 ;  
 	 	 _ _ b l o c k _ u s e r _ n u m b e r   =   " 6 " ;  
 	 	 _ b e f o r e E x e c u t e E n a b l e d   =   t r u e ;  
  
 	 	 / /   I C   i n p u t   p a r a m e t e r s  
 	 	 d V o l u m e S i z e . V a l u e   =   0 . 1 ;  
 	 	 d p S t o p L o s s . V a l u e   =   1 0 0 . 0 ;  
 	 	 d d S t o p L o s s . V a l u e   =   0 . 0 1 ;  
 	 	 d p T a k e P r o f i t . V a l u e   =   1 0 0 . 0 ;  
 	 	 d d T a k e P r o f i t . V a l u e   =   0 . 0 1 ;  
 	 	 d E x p . M o d e T i m e S h i f t   =   2 ;  
 	 	 d E x p . T i m e S h i f t D a y s   =   1 . 0 ;  
 	 	 d E x p . T i m e S k i p W e e k d a y s   =   t r u e ;  
 	 }  
  
 	 p u b l i c :   / *   C u s t o m   m e t h o d s   * /  
 	 v i r t u a l   d o u b l e   _ d V o l u m e S i z e _ ( )   { r e t u r n   d V o l u m e S i z e . _ e x e c u t e _ ( ) ; }  
 	 v i r t u a l   d o u b l e   _ d l S t o p L o s s _ ( )   { r e t u r n   d l S t o p L o s s . _ e x e c u t e _ ( ) ; }  
 	 v i r t u a l   d o u b l e   _ d p S t o p L o s s _ ( )   { r e t u r n   d p S t o p L o s s . _ e x e c u t e _ ( ) ; }  
 	 v i r t u a l   d o u b l e   _ d d S t o p L o s s _ ( )   { r e t u r n   d d S t o p L o s s . _ e x e c u t e _ ( ) ; }  
 	 v i r t u a l   d o u b l e   _ d l T a k e P r o f i t _ ( )   { r e t u r n   d l T a k e P r o f i t . _ e x e c u t e _ ( ) ; }  
 	 v i r t u a l   d o u b l e   _ d p T a k e P r o f i t _ ( )   { r e t u r n   d p T a k e P r o f i t . _ e x e c u t e _ ( ) ; }  
 	 v i r t u a l   d o u b l e   _ d d T a k e P r o f i t _ ( )   { r e t u r n   d d T a k e P r o f i t . _ e x e c u t e _ ( ) ; }  
 	 v i r t u a l   d a t e t i m e   _ d E x p _ ( )   { r e t u r n   d E x p . _ e x e c u t e _ ( ) ; }  
  
 	 p u b l i c :   / *   C a l l b a c k   &   R u n   * /  
 	 v i r t u a l   v o i d   _ c a l l b a c k _ ( i n t   v a l u e )   {  
 	 }  
  
 	 v i r t u a l   v o i d   _ b e f o r e E x e c u t e _ ( )  
 	 {  
 	 	 S y m b o l   =   ( s t r i n g ) C u r r e n t S y m b o l ( ) ;  
 	 	 V o l u m e S i z e   =   ( d o u b l e ) v : : l o t s ;  
 	 	 S t o p L o s s P i p s   =   ( d o u b l e ) c : : S L ;  
 	 	 T a k e P r o f i t P i p s   =   ( d o u b l e ) c : : T P ;  
 	 	 A r r o w C o l o r B u y   =   ( c o l o r ) c l r B l u e ;  
 	 }  
 } ;  
  
 / /   B l o c k   7   ( F o r m u l a )  
 c l a s s   B l o c k 6 :   p u b l i c   M D L _ F o r m u l a _ 2 < M D L I C _ v a l u e _ v a l u e , d o u b l e , s t r i n g , M D L I C _ v a l u e _ v a l u e , d o u b l e >  
 {  
  
 	 p u b l i c :   / *   C o n s t r u c t o r   * /  
 	 B l o c k 6 ( )   {  
 	 	 _ _ b l o c k _ n u m b e r   =   6 ;  
 	 	 _ _ b l o c k _ u s e r _ n u m b e r   =   " 7 " ;  
  
  
 	 	 / /   F i l l   t h e   l i s t   o f   o u t b o u n d   b l o c k s  
 	 	 i n t   _ _ _ o u t b o u n d _ b l o c k s [ 1 ]   =   { 2 } ;  
 	 	 A r r a y C o p y ( _ _ o u t b o u n d _ b l o c k s ,   _ _ _ o u t b o u n d _ b l o c k s ) ;  
 	 }  
  
 	 p u b l i c :   / *   C u s t o m   m e t h o d s   * /  
 	 v i r t u a l   d o u b l e   _ L o _ ( )   {  
 	 	 L o . V a l u e   =   v : : w i n s ;  
  
 	 	 r e t u r n   L o . _ e x e c u t e _ ( ) ;  
 	 }  
 	 v i r t u a l   d o u b l e   _ R o _ ( )   { r e t u r n   R o . _ e x e c u t e _ ( ) ; }  
  
 	 p u b l i c :   / *   C a l l b a c k   &   R u n   * /  
 	 v i r t u a l   v o i d   _ c a l l b a c k _ ( i n t   v a l u e )   {  
 	 	 i f   ( v a l u e   = =   1 )   {  
 	 	 	 _ b l o c k s _ [ 2 ] . r u n ( 6 ) ;  
 	 	 }  
 	 }  
 } ;  
  
 / /   B l o c k   1 2   ( F o r m u l a )  
 c l a s s   B l o c k 7 :   p u b l i c   M D L _ F o r m u l a _ 3 < M D L I C _ v a l u e _ v a l u e , d o u b l e , s t r i n g , M D L I C _ v a l u e _ v a l u e , d o u b l e >  
 {  
  
 	 p u b l i c :   / *   C o n s t r u c t o r   * /  
 	 B l o c k 7 ( )   {  
 	 	 _ _ b l o c k _ n u m b e r   =   7 ;  
 	 	 _ _ b l o c k _ u s e r _ n u m b e r   =   " 1 2 " ;  
  
  
 	 	 / /   F i l l   t h e   l i s t   o f   o u t b o u n d   b l o c k s  
 	 	 i n t   _ _ _ o u t b o u n d _ b l o c k s [ 1 ]   =   { 2 } ;  
 	 	 A r r a y C o p y ( _ _ o u t b o u n d _ b l o c k s ,   _ _ _ o u t b o u n d _ b l o c k s ) ;  
 	 }  
  
 	 p u b l i c :   / *   C u s t o m   m e t h o d s   * /  
 	 v i r t u a l   d o u b l e   _ L o _ ( )   {  
 	 	 L o . V a l u e   =   v : : l o s s e s ;  
  
 	 	 r e t u r n   L o . _ e x e c u t e _ ( ) ;  
 	 }  
 	 v i r t u a l   d o u b l e   _ R o _ ( )   { r e t u r n   R o . _ e x e c u t e _ ( ) ; }  
  
 	 p u b l i c :   / *   C a l l b a c k   &   R u n   * /  
 	 v i r t u a l   v o i d   _ c a l l b a c k _ ( i n t   v a l u e )   {  
 	 	 i f   ( v a l u e   = =   1 )   {  
 	 	 	 _ b l o c k s _ [ 2 ] . r u n ( 7 ) ;  
 	 	 }  
 	 }  
 } ;  
  
 / /   B l o c k   1 3   ( F o r m u l a )  
 c l a s s   B l o c k 8 :   p u b l i c   M D L _ F o r m u l a _ 4 < M D L I C _ a c c o u n t _ A c c o u n t E q u i t y , d o u b l e , s t r i n g , M D L I C _ v a l u e _ v a l u e , d o u b l e >  
 {  
  
 	 p u b l i c :   / *   C o n s t r u c t o r   * /  
 	 B l o c k 8 ( )   {  
 	 	 _ _ b l o c k _ n u m b e r   =   8 ;  
 	 	 _ _ b l o c k _ u s e r _ n u m b e r   =   " 1 3 " ;  
  
  
 	 	 / /   F i l l   t h e   l i s t   o f   o u t b o u n d   b l o c k s  
 	 	 i n t   _ _ _ o u t b o u n d _ b l o c k s [ 1 ]   =   { 4 } ;  
 	 	 A r r a y C o p y ( _ _ o u t b o u n d _ b l o c k s ,   _ _ _ o u t b o u n d _ b l o c k s ) ;  
 	 	 / /   B l o c k   i n p u t   p a r a m e t e r s  
 	 	 c o m p a r e   =   " / " ;  
 	 }  
  
 	 p u b l i c :   / *   C u s t o m   m e t h o d s   * /  
 	 v i r t u a l   d o u b l e   _ L o _ ( )   { r e t u r n   L o . _ e x e c u t e _ ( ) ; }  
 	 v i r t u a l   d o u b l e   _ R o _ ( )   {  
 	 	 R o . V a l u e   =   _ e x t e r n s : : i n p 1 3 _ R o _ V a l u e ;  
  
 	 	 r e t u r n   R o . _ e x e c u t e _ ( ) ;  
 	 }  
  
 	 p u b l i c :   / *   C a l l b a c k   &   R u n   * /  
 	 v i r t u a l   v o i d   _ c a l l b a c k _ ( i n t   v a l u e )   {  
 	 	 i f   ( v a l u e   = =   1 )   {  
 	 	 	 _ b l o c k s _ [ 4 ] . r u n ( 8 ) ;  
 	 	 }  
 	 }  
 } ;  
  
 / /   B l o c k   1 6   ( F o r m u l a )  
 c l a s s   B l o c k 9 :   p u b l i c   M D L _ F o r m u l a _ 5 < M D L I C _ v a l u e _ v a l u e , d o u b l e , s t r i n g , M D L I C _ v a l u e _ v a l u e , d o u b l e >  
 {  
  
 	 p u b l i c :   / *   C o n s t r u c t o r   * /  
 	 B l o c k 9 ( )   {  
 	 	 _ _ b l o c k _ n u m b e r   =   9 ;  
 	 	 _ _ b l o c k _ u s e r _ n u m b e r   =   " 1 6 " ;  
  
  
 	 	 / /   F i l l   t h e   l i s t   o f   o u t b o u n d   b l o c k s  
 	 	 i n t   _ _ _ o u t b o u n d _ b l o c k s [ 1 ]   =   { 4 } ;  
 	 	 A r r a y C o p y ( _ _ o u t b o u n d _ b l o c k s ,   _ _ _ o u t b o u n d _ b l o c k s ) ;  
 	 	 / /   B l o c k   i n p u t   p a r a m e t e r s  
 	 	 c o m p a r e   =   " * " ;  
 	 }  
  
 	 p u b l i c :   / *   C u s t o m   m e t h o d s   * /  
 	 v i r t u a l   d o u b l e   _ L o _ ( )   {  
 	 	 L o . V a l u e   =   v : : l o t s ;  
  
 	 	 r e t u r n   L o . _ e x e c u t e _ ( ) ;  
 	 }  
 	 v i r t u a l   d o u b l e   _ R o _ ( )   {  
 	 	 R o . V a l u e   =   _ e x t e r n s : : i n p 1 6 _ R o _ V a l u e ;  
  
 	 	 r e t u r n   R o . _ e x e c u t e _ ( ) ;  
 	 }  
  
 	 p u b l i c :   / *   C a l l b a c k   &   R u n   * /  
 	 v i r t u a l   v o i d   _ c a l l b a c k _ ( i n t   v a l u e )   {  
 	 	 i f   ( v a l u e   = =   1 )   {  
 	 	 	 _ b l o c k s _ [ 4 ] . r u n ( 9 ) ;  
 	 	 }  
 	 }  
 } ;  
  
 / /   B l o c k   1 8   ( C o n d i t i o n )  
 c l a s s   B l o c k 1 0 :   p u b l i c   M D L _ C o n d i t i o n < M D L I C _ v a l u e _ v a l u e , d o u b l e , s t r i n g , M D L I C _ v a l u e _ v a l u e , d o u b l e , i n t >  
 {  
  
 	 p u b l i c :   / *   C o n s t r u c t o r   * /  
 	 B l o c k 1 0 ( )   {  
 	 	 _ _ b l o c k _ n u m b e r   =   1 0 ;  
 	 	 _ _ b l o c k _ u s e r _ n u m b e r   =   " 1 8 " ;  
  
  
 	 	 / /   F i l l   t h e   l i s t   o f   o u t b o u n d   b l o c k s  
 	 	 i n t   _ _ _ o u t b o u n d _ b l o c k s [ 1 ]   =   { 8 } ;  
 	 	 A r r a y C o p y ( _ _ o u t b o u n d _ b l o c k s ,   _ _ _ o u t b o u n d _ b l o c k s ) ;  
 	 	 / /   B l o c k   i n p u t   p a r a m e t e r s  
 	 	 c o m p a r e   =   " = = " ;  
 	 }  
  
 	 p u b l i c :   / *   C u s t o m   m e t h o d s   * /  
 	 v i r t u a l   d o u b l e   _ L o _ ( )   {  
 	 	 L o . V a l u e   =   v : : w i n s ;  
  
 	 	 r e t u r n   L o . _ e x e c u t e _ ( ) ;  
 	 }  
 	 v i r t u a l   d o u b l e   _ R o _ ( )   {  
 	 	 R o . V a l u e   =   c : : N _ t r a d e s _ p e r _ s e t ;  
  
 	 	 r e t u r n   R o . _ e x e c u t e _ ( ) ;  
 	 }  
  
 	 p u b l i c :   / *   C a l l b a c k   &   R u n   * /  
 	 v i r t u a l   v o i d   _ c a l l b a c k _ ( i n t   v a l u e )   {  
 	 	 i f   ( v a l u e   = =   1 )   {  
 	 	 	 _ b l o c k s _ [ 8 ] . r u n ( 1 0 ) ;  
 	 	 }  
 	 }  
 } ;  
  
 / /   B l o c k   1 9   ( C o n d i t i o n )  
 c l a s s   B l o c k 1 1 :   p u b l i c   M D L _ C o n d i t i o n < M D L I C _ v a l u e _ v a l u e , d o u b l e , s t r i n g , M D L I C _ v a l u e _ v a l u e , d o u b l e , i n t >  
 {  
  
 	 p u b l i c :   / *   C o n s t r u c t o r   * /  
 	 B l o c k 1 1 ( )   {  
 	 	 _ _ b l o c k _ n u m b e r   =   1 1 ;  
 	 	 _ _ b l o c k _ u s e r _ n u m b e r   =   " 1 9 " ;  
  
  
 	 	 / /   F i l l   t h e   l i s t   o f   o u t b o u n d   b l o c k s  
 	 	 i n t   _ _ _ o u t b o u n d _ b l o c k s [ 1 ]   =   { 9 } ;  
 	 	 A r r a y C o p y ( _ _ o u t b o u n d _ b l o c k s ,   _ _ _ o u t b o u n d _ b l o c k s ) ;  
 	 	 / /   B l o c k   i n p u t   p a r a m e t e r s  
 	 	 c o m p a r e   =   " = = " ;  
 	 }  
  
 	 p u b l i c :   / *   C u s t o m   m e t h o d s   * /  
 	 v i r t u a l   d o u b l e   _ L o _ ( )   {  
 	 	 L o . V a l u e   =   v : : l o s s e s ;  
  
 	 	 r e t u r n   L o . _ e x e c u t e _ ( ) ;  
 	 }  
 	 v i r t u a l   d o u b l e   _ R o _ ( )   {  
 	 	 R o . V a l u e   =   c : : N _ t r a d e s _ p e r _ s e t ;  
  
 	 	 r e t u r n   R o . _ e x e c u t e _ ( ) ;  
 	 }  
  
 	 p u b l i c :   / *   C a l l b a c k   &   R u n   * /  
 	 v i r t u a l   v o i d   _ c a l l b a c k _ ( i n t   v a l u e )   {  
 	 	 i f   ( v a l u e   = =   1 )   {  
 	 	 	 _ b l o c k s _ [ 9 ] . r u n ( 1 1 ) ;  
 	 	 }  
 	 }  
 } ;  
  
 / /   B l o c k   2 0   ( N o   t r a d e )  
 c l a s s   B l o c k 1 2 :   p u b l i c   M D L _ N o O p e n e d O r d e r s < s t r i n g , s t r i n g , s t r i n g , s t r i n g , s t r i n g >  
 {  
  
 	 p u b l i c :   / *   C o n s t r u c t o r   * /  
 	 B l o c k 1 2 ( )   {  
 	 	 _ _ b l o c k _ n u m b e r   =   1 2 ;  
 	 	 _ _ b l o c k _ u s e r _ n u m b e r   =   " 2 0 " ;  
 	 	 _ b e f o r e E x e c u t e E n a b l e d   =   t r u e ;  
  
 	 	 / /   F i l l   t h e   l i s t   o f   o u t b o u n d   b l o c k s  
 	 	 i n t   _ _ _ o u t b o u n d _ b l o c k s [ 1 ]   =   { 1 3 } ;  
 	 	 A r r a y C o p y ( _ _ o u t b o u n d _ b l o c k s ,   _ _ _ o u t b o u n d _ b l o c k s ) ;  
 	 }  
  
 	 p u b l i c :   / *   C a l l b a c k   &   R u n   * /  
 	 v i r t u a l   v o i d   _ c a l l b a c k _ ( i n t   v a l u e )   {  
 	 	 i f   ( v a l u e   = =   1 )   {  
 	 	 	 _ b l o c k s _ [ 1 3 ] . r u n ( 1 2 ) ;  
 	 	 }  
 	 }  
  
 	 v i r t u a l   v o i d   _ b e f o r e E x e c u t e _ ( )  
 	 {  
 	 	 S y m b o l   =   ( s t r i n g ) C u r r e n t S y m b o l ( ) ;  
 	 }  
 } ;  
  
 / /   B l o c k   2 1   ( B u y   n o w )  
 c l a s s   B l o c k 1 3 :   p u b l i c   M D L _ B u y N o w < s t r i n g , s t r i n g , s t r i n g , d o u b l e , d o u b l e , d o u b l e , d o u b l e , d o u b l e , M D L I C _ v a l u e _ v a l u e , d o u b l e , d o u b l e , d o u b l e , d o u b l e , d o u b l e , d o u b l e , d o u b l e , d o u b l e , i n t , i n t , d o u b l e , b o o l , d o u b l e , d o u b l e , b o o l , d o u b l e , s t r i n g , b o o l , d o u b l e , s t r i n g , s t r i n g , b o o l , d o u b l e , s t r i n g , d o u b l e , d o u b l e , d o u b l e , M D L I C _ v a l u e _ v a l u e , d o u b l e , M D L I C _ v a l u e _ v a l u e , d o u b l e , M D L I C _ v a l u e _ v a l u e , d o u b l e , s t r i n g , d o u b l e , d o u b l e , d o u b l e , M D L I C _ v a l u e _ v a l u e , d o u b l e , M D L I C _ v a l u e _ v a l u e , d o u b l e , M D L I C _ v a l u e _ v a l u e , d o u b l e , s t r i n g , i n t , i n t , i n t , M D L I C _ v a l u e _ t i m e , d a t e t i m e , u l o n g , s t r i n g , c o l o r >  
 {  
  
 	 p u b l i c :   / *   C o n s t r u c t o r   * /  
 	 B l o c k 1 3 ( )   {  
 	 	 _ _ b l o c k _ n u m b e r   =   1 3 ;  
 	 	 _ _ b l o c k _ u s e r _ n u m b e r   =   " 2 1 " ;  
 	 	 _ b e f o r e E x e c u t e E n a b l e d   =   t r u e ;  
  
 	 	 / /   I C   i n p u t   p a r a m e t e r s  
 	 	 d V o l u m e S i z e . V a l u e   =   0 . 1 ;  
 	 	 d p S t o p L o s s . V a l u e   =   1 0 0 . 0 ;  
 	 	 d d S t o p L o s s . V a l u e   =   0 . 0 1 ;  
 	 	 d p T a k e P r o f i t . V a l u e   =   1 0 0 . 0 ;  
 	 	 d d T a k e P r o f i t . V a l u e   =   0 . 0 1 ;  
 	 	 d E x p . M o d e T i m e S h i f t   =   2 ;  
 	 	 d E x p . T i m e S h i f t D a y s   =   1 . 0 ;  
 	 	 d E x p . T i m e S k i p W e e k d a y s   =   t r u e ;  
 	 	 / /   B l o c k   i n p u t   p a r a m e t e r s  
 	 	 V o l u m e S i z e   =   0 . 0 1 ;  
 	 }  
  
 	 p u b l i c :   / *   C u s t o m   m e t h o d s   * /  
 	 v i r t u a l   d o u b l e   _ d V o l u m e S i z e _ ( )   { r e t u r n   d V o l u m e S i z e . _ e x e c u t e _ ( ) ; }  
 	 v i r t u a l   d o u b l e   _ d l S t o p L o s s _ ( )   { r e t u r n   d l S t o p L o s s . _ e x e c u t e _ ( ) ; }  
 	 v i r t u a l   d o u b l e   _ d p S t o p L o s s _ ( )   { r e t u r n   d p S t o p L o s s . _ e x e c u t e _ ( ) ; }  
 	 v i r t u a l   d o u b l e   _ d d S t o p L o s s _ ( )   { r e t u r n   d d S t o p L o s s . _ e x e c u t e _ ( ) ; }  
 	 v i r t u a l   d o u b l e   _ d l T a k e P r o f i t _ ( )   { r e t u r n   d l T a k e P r o f i t . _ e x e c u t e _ ( ) ; }  
 	 v i r t u a l   d o u b l e   _ d p T a k e P r o f i t _ ( )   { r e t u r n   d p T a k e P r o f i t . _ e x e c u t e _ ( ) ; }  
 	 v i r t u a l   d o u b l e   _ d d T a k e P r o f i t _ ( )   { r e t u r n   d d T a k e P r o f i t . _ e x e c u t e _ ( ) ; }  
 	 v i r t u a l   d a t e t i m e   _ d E x p _ ( )   { r e t u r n   d E x p . _ e x e c u t e _ ( ) ; }  
  
 	 p u b l i c :   / *   C a l l b a c k   &   R u n   * /  
 	 v i r t u a l   v o i d   _ c a l l b a c k _ ( i n t   v a l u e )   {  
 	 }  
  
 	 v i r t u a l   v o i d   _ b e f o r e E x e c u t e _ ( )  
 	 {  
 	 	 S y m b o l   =   ( s t r i n g ) C u r r e n t S y m b o l ( ) ;  
 	 	 S t o p L o s s P i p s   =   ( d o u b l e ) c : : S L ;  
 	 	 T a k e P r o f i t P i p s   =   ( d o u b l e ) c : : T P ;  
 	 	 A r r o w C o l o r B u y   =   ( c o l o r ) c l r B l u e ;  
 	 }  
 } ;  
  
 / /   B l o c k   2 2   ( C o n d i t i o n )  
 c l a s s   B l o c k 1 4 :   p u b l i c   M D L _ C o n d i t i o n < M D L I C _ v a l u e _ v a l u e , d o u b l e , s t r i n g , M D L I C _ v a l u e _ v a l u e , d o u b l e , i n t >  
 {  
  
 	 p u b l i c :   / *   C o n s t r u c t o r   * /  
 	 B l o c k 1 4 ( )   {  
 	 	 _ _ b l o c k _ n u m b e r   =   1 4 ;  
 	 	 _ _ b l o c k _ u s e r _ n u m b e r   =   " 2 2 " ;  
  
  
 	 	 / /   F i l l   t h e   l i s t   o f   o u t b o u n d   b l o c k s  
 	 	 i n t   _ _ _ o u t b o u n d _ b l o c k s [ 1 ]   =   { 1 5 } ;  
 	 	 A r r a y C o p y ( _ _ o u t b o u n d _ b l o c k s ,   _ _ _ o u t b o u n d _ b l o c k s ) ;  
 	 	 / /   B l o c k   i n p u t   p a r a m e t e r s  
 	 	 c o m p a r e   =   " = = " ;  
 	 }  
  
 	 p u b l i c :   / *   C u s t o m   m e t h o d s   * /  
 	 v i r t u a l   d o u b l e   _ L o _ ( )   {  
 	 	 L o . V a l u e   =   v : : w i n s ;  
  
 	 	 r e t u r n   L o . _ e x e c u t e _ ( ) ;  
 	 }  
 	 v i r t u a l   d o u b l e   _ R o _ ( )   {  
 	 	 R o . V a l u e   =   c : : N _ t r a d e s _ p e r _ s e t ;  
  
 	 	 r e t u r n   R o . _ e x e c u t e _ ( ) ;  
 	 }  
  
 	 p u b l i c :   / *   C a l l b a c k   &   R u n   * /  
 	 v i r t u a l   v o i d   _ c a l l b a c k _ ( i n t   v a l u e )   {  
 	 	 i f   ( v a l u e   = =   0 )   {  
 	 	 	 _ b l o c k s _ [ 1 5 ] . r u n ( 1 4 ) ;  
 	 	 }  
 	 }  
 } ;  
  
 / /   B l o c k   2 3   ( C o n d i t i o n )  
 c l a s s   B l o c k 1 5 :   p u b l i c   M D L _ C o n d i t i o n < M D L I C _ v a l u e _ v a l u e , d o u b l e , s t r i n g , M D L I C _ v a l u e _ v a l u e , d o u b l e , i n t >  
 {  
  
 	 p u b l i c :   / *   C o n s t r u c t o r   * /  
 	 B l o c k 1 5 ( )   {  
 	 	 _ _ b l o c k _ n u m b e r   =   1 5 ;  
 	 	 _ _ b l o c k _ u s e r _ n u m b e r   =   " 2 3 " ;  
  
  
 	 	 / /   F i l l   t h e   l i s t   o f   o u t b o u n d   b l o c k s  
 	 	 i n t   _ _ _ o u t b o u n d _ b l o c k s [ 1 ]   =   { 4 } ;  
 	 	 A r r a y C o p y ( _ _ o u t b o u n d _ b l o c k s ,   _ _ _ o u t b o u n d _ b l o c k s ) ;  
 	 	 / /   B l o c k   i n p u t   p a r a m e t e r s  
 	 	 c o m p a r e   =   " = = " ;  
 	 }  
  
 	 p u b l i c :   / *   C u s t o m   m e t h o d s   * /  
 	 v i r t u a l   d o u b l e   _ L o _ ( )   {  
 	 	 L o . V a l u e   =   v : : l o s s e s ;  
  
 	 	 r e t u r n   L o . _ e x e c u t e _ ( ) ;  
 	 }  
 	 v i r t u a l   d o u b l e   _ R o _ ( )   {  
 	 	 R o . V a l u e   =   c : : N _ t r a d e s _ p e r _ s e t ;  
  
 	 	 r e t u r n   R o . _ e x e c u t e _ ( ) ;  
 	 }  
  
 	 p u b l i c :   / *   C a l l b a c k   &   R u n   * /  
 	 v i r t u a l   v o i d   _ c a l l b a c k _ ( i n t   v a l u e )   {  
 	 	 i f   ( v a l u e   = =   0 )   {  
 	 	 	 _ b l o c k s _ [ 4 ] . r u n ( 1 5 ) ;  
 	 	 }  
 	 }  
 } ;  
  
  
 / * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * /  
 / /   + - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - +   / /  
 / /   |                                                                                                       F u n c t i o n s                                                                                                             |   / /  
 / /   |                                                                   S y s t e m   a n d   C u s t o m   f u n c t i o n s   u s e d   i n   t h e   p r o g r a m                                                                     |   / /  
 / /   + - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - +   / /  
 / * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * /  
  
  
 d o u b l e   A c c o u n t B a l a n c e A t S t a r t ( )  
 {  
       / /   T h i s   f u n c t i o n   M U S T   b e   r u n   o n c e   a t   p o g r a m ' s   s t a r t  
 	 s t a t i c   d o u b l e   m e m o r y   =   0 ;  
  
 	 i f   ( m e m o r y   = =   0 )   m e m o r y   =   N o r m a l i z e D o u b l e ( A c c o u n t I n f o D o u b l e ( A C C O U N T _ B A L A N C E ) ,   2 ) ;  
  
 	 r e t u r n   m e m o r y ;  
 }  
  
 d o u b l e   A l i g n L o t s ( s t r i n g   s y m b o l ,   d o u b l e   l o t s ,   d o u b l e   l o w e r l o t s = 0 ,   d o u b l e   u p p e r l o t s = 0 )  
 {  
 	 d o u b l e   L o t S t e p   =   S y m b o l I n f o D o u b l e ( s y m b o l ,   S Y M B O L _ V O L U M E _ S T E P ) ;  
 	 d o u b l e   L o t S i z e   =   S y m b o l I n f o D o u b l e ( s y m b o l ,   S Y M B O L _ T R A D E _ C O N T R A C T _ S I Z E ) ;  
 	 d o u b l e   M i n L o t s   =   S y m b o l I n f o D o u b l e ( s y m b o l ,   S Y M B O L _ V O L U M E _ M I N ) ;  
 	 d o u b l e   M a x L o t s   =   S y m b o l I n f o D o u b l e ( s y m b o l ,   S Y M B O L _ V O L U M E _ M A X ) ;  
  
 	 i f   ( L o t S t e p   >   M i n L o t s )   M i n L o t s   =   L o t S t e p ;  
  
 	 i f   ( l o t s   = =   E M P T Y _ V A L U E )   { l o t s   =   0 ; }  
  
 	 l o t s   =   M a t h R o u n d ( l o t s / L o t S t e p ) * L o t S t e p ;  
  
 	 i f   ( l o t s   <   M i n L o t s )   { l o t s   =   M i n L o t s ; }  
 	 i f   ( l o t s   >   M a x L o t s )   { l o t s   =   M a x L o t s ; }  
  
 	 i f   ( l o w e r l o t s   >   0 )  
 	 {  
 	 	 l o w e r l o t s   =   M a t h R o u n d ( l o w e r l o t s / L o t S t e p ) * L o t S t e p ;  
 	 	 i f   ( l o t s   <   l o w e r l o t s )   { l o t s   =   l o w e r l o t s ; }  
 	 }  
  
 	 i f   ( u p p e r l o t s   >   0 )  
 	 {  
 	 	 u p p e r l o t s   =   M a t h R o u n d ( u p p e r l o t s / L o t S t e p ) * L o t S t e p ;  
 	 	 i f   ( l o t s   >   u p p e r l o t s )   { l o t s   =   u p p e r l o t s ; }  
 	 }  
  
 	 r e t u r n   l o t s ;  
 }  
  
 d o u b l e   A l i g n S t o p L o s s (  
 	 s t r i n g   s y m b o l ,  
 	 i n t   t y p e ,  
 	 d o u b l e   p r i c e ,  
 	 d o u b l e   s l o   =   0 ,   / /   o r i g i n a l   s l ,   u s e d   w h e n   m o d i f y i n g  
 	 d o u b l e   s l l   =   0 ,  
 	 d o u b l e   s l p   =   0 ,  
 	 b o o l   c o n s i d e r _ f r e e z e l e v e l   =   f a l s e  
 	 )  
 {  
 	 d o u b l e   s l   =   0 ;  
  
 	 i f   ( M a t h A b s ( s l l )   = =   E M P T Y _ V A L U E )   { s l l   =   0 ; }  
 	 i f   ( M a t h A b s ( s l p )   = =   E M P T Y _ V A L U E )   { s l p   =   0 ; }  
  
 	 i f   ( s l l   = =   0   & &   s l p   = =   0 )  
 	 {  
 	 	 r e t u r n   0 ;  
 	 }  
  
 	 i f   ( p r i c e   < =   0 )  
 	 {  
 	 	 P r i n t ( " A l i g n S t o p L o s s ( )   e r r o r :   N o   p r i c e   e n t e r e d " ) ;  
  
 	 	 r e t u r n ( - 1 ) ;  
 	 }  
  
 	 d o u b l e   p o i n t   =   S y m b o l I n f o D o u b l e ( s y m b o l ,   S Y M B O L _ P O I N T ) ;  
 	 i n t   d i g i t s       =   ( i n t ) S y m b o l I n f o I n t e g e r ( s y m b o l ,   S Y M B O L _ D I G I T S ) ;  
 	 s l p                     =   s l p   *   P i p V a l u e ( s y m b o l )   *   p o i n t ;  
  
 	 / / - -   b u y - s e l l   i d e n t i f i e r   - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  
 	 i n t   b s   =   1 ;  
  
 	 i f   (  
 	 	       t y p e   = =   O P _ S E L L  
 	 	 | |   t y p e   = =   O P _ S E L L S T O P  
 	 	 | |   t y p e   = =   O P _ S E L L L I M I T  
  
 	 	 )  
 	 {  
 	 	 b s   =   - 1 ;  
 	 }  
  
 	 / / - -   p r i c e s   t h a t   w i l l   b e   u s e d   - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  
 	 d o u b l e   a s k b i d   =   p r i c e ;  
 	 d o u b l e   b i d a s k   =   p r i c e ;  
 	  
 	 i f   ( t y p e   <   2 )  
 	 {  
 	 	 d o u b l e   a s k   =   S y m b o l I n f o D o u b l e ( s y m b o l ,   S Y M B O L _ A S K ) ;  
 	 	 d o u b l e   b i d   =   S y m b o l I n f o D o u b l e ( s y m b o l ,   S Y M B O L _ B I D ) ;  
 	 	  
 	 	 a s k b i d   =   a s k ;  
 	 	 b i d a s k   =   b i d ;  
  
 	 	 i f   ( b s   <   0 )  
 	 	 {  
 	 	     a s k b i d   =   b i d ;  
 	 	     b i d a s k   =   a s k ;  
 	 	 }  
 	 }  
  
 	 / / - -   b u i l d   s l   l e v e l   - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -    
 	 i f   ( s l l   = =   0   & &   s l p   ! =   0 )   { s l l   =   p r i c e ; }  
  
 	 i f   ( s l l   >   0 )   { s l   =   s l l   -   s l p   *   b s ; }  
  
 	 i f   ( s l   <   0 )  
 	 {  
 	 	 r e t u r n   - 1 ;  
 	 }  
  
 	 s l     =   N o r m a l i z e D o u b l e ( s l ,   d i g i t s ) ;  
 	 s l o   =   N o r m a l i z e D o u b l e ( s l o ,   d i g i t s ) ;  
  
 	 i f   ( s l   = =   s l o )  
 	 {  
 	 	 r e t u r n   s l ;  
 	 }  
  
 	 / / - -   b u i l d   l i m i t   l e v e l s   - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  
 	 d o u b l e   m i n s t o p s   =   ( d o u b l e ) S y m b o l I n f o I n t e g e r ( s y m b o l ,   S Y M B O L _ T R A D E _ S T O P S _ L E V E L ) ;  
  
 	 i f   ( c o n s i d e r _ f r e e z e l e v e l   = =   t r u e )  
 	 {  
 	 	 d o u b l e   f r e e z e l e v e l   =   ( d o u b l e ) S y m b o l I n f o I n t e g e r ( s y m b o l ,   S Y M B O L _ T R A D E _ F R E E Z E _ L E V E L ) ;  
  
 	 	 i f   ( f r e e z e l e v e l   >   m i n s t o p s )   { m i n s t o p s   =   f r e e z e l e v e l ; }  
 	 }  
  
 	 m i n s t o p s   =   N o r m a l i z e D o u b l e ( m i n s t o p s   *   p o i n t , d i g i t s ) ;  
  
 	 d o u b l e   s l l i m i t   =   b i d a s k   -   m i n s t o p s   *   b s ;   / /   S L   m i n   p r i c e   l e v e l  
  
 	 / / - -   c h e c k   a n d   a l i g n   s l ,   p r i n t   e r r o r s   - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  
 	 / / - -   d o   n o t   d o   i t   w h e n   t h e   s t o p   i s   t h e   s a m e   a s   t h e   o r i g i n a l  
 	 i f   ( s l   >   0   & &   s l   ! =   s l o )  
 	 {  
 	 	 i f   ( ( b s   >   0   & &   s l   >   a s k b i d )   | |   ( b s   <   0   & &   s l   <   a s k b i d ) )  
 	 	 {  
 	 	 	 s t r i n g   a b s t r   =   " " ;  
  
 	 	 	 i f   ( b s   >   0 )   { a b s t r   =   " B i d " ; }   e l s e   { a b s t r   =   " A s k " ; }  
  
 	 	 	 P r i n t (  
 	 	 	 	 " E r r o r :   I n v a l i d   S L   r e q u e s t e d   ( " ,  
 	 	 	 	 D o u b l e T o S t r ( s l ,   d i g i t s ) ,  
 	 	 	 	 "   f o r   " ,   a b s t r ,   "   p r i c e   " ,  
 	 	 	 	 b i d a s k ,  
 	 	 	 	 " ) "  
 	 	 	 ) ;  
  
 	 	 	 r e t u r n   - 1 ;  
 	 	 }  
 	 	 e l s e   i f   ( ( b s   >   0   & &   s l   >   s l l i m i t )   | |   ( b s   <   0   & &   s l   <   s l l i m i t ) )  
 	 	 {  
 	 	 	 i f   ( U S E _ V I R T U A L _ S T O P S )  
 	 	 	 {  
 	 	 	 	 r e t u r n   s l ;  
 	 	 	 }  
  
 	 	 	 P r i n t (  
 	 	 	 	 " W a r n i n g :   T o o   s h o r t   S L   r e q u e s t e d   ( " ,  
 	 	 	 	 D o u b l e T o S t r ( s l ,   d i g i t s ) ,  
 	 	 	 	 "   o r   " ,  
 	 	 	 	 D o u b l e T o S t r ( M a t h A b s ( s l   -   a s k b i d )   /   p o i n t ,   0 ) ,  
 	 	 	 	 "   p o i n t s ) ,   m i n i m u m   w i l l   b e   t a k e n   ( " ,  
 	 	 	 	 D o u b l e T o S t r ( s l l i m i t ,   d i g i t s ) ,  
 	 	 	 	 "   o r   " ,  
 	 	 	 	 D o u b l e T o S t r ( M a t h A b s ( a s k b i d   -   s l l i m i t )   /   p o i n t ,   0 ) ,  
 	 	 	 	 "   p o i n t s ) "  
 	 	 	 ) ;  
  
 	 	 	 s l   =   s l l i m i t ;  
  
 	 	 	 r e t u r n   s l ;  
 	 	 }  
 	 }  
  
 	 / /   a l i g n   b y   t h e   t i c k s i z e  
 	 d o u b l e   t i c k s i z e   =   S y m b o l I n f o D o u b l e ( s y m b o l ,   S Y M B O L _ T R A D E _ T I C K _ S I Z E ) ;  
 	 s l   =   M a t h R o u n d ( s l   /   t i c k s i z e )   *   t i c k s i z e ;  
  
 	 r e t u r n   s l ;  
 }  
  
 d o u b l e   A l i g n T a k e P r o f i t (  
 	 s t r i n g   s y m b o l ,  
 	 i n t   t y p e ,  
 	 d o u b l e   p r i c e ,  
 	 d o u b l e   t p o   =   0 ,   / /   o r i g i n a l   t p ,   u s e d   w h e n   m o d i f y i n g  
 	 d o u b l e   t p l   =   0 ,  
 	 d o u b l e   t p p   =   0 ,  
 	 b o o l   c o n s i d e r _ f r e e z e l e v e l   =   f a l s e  
 	 )  
 {  
 	 d o u b l e   t p = 0 ;  
 	  
 	 i f   ( M a t h A b s ( t p l )   = =   E M P T Y _ V A L U E )   { t p l   =   0 ; }  
 	 i f   ( M a t h A b s ( t p p )   = =   E M P T Y _ V A L U E )   { t p p   =   0 ; }  
  
 	 i f   ( t p l   = =   0   & &   t p p   = =   0 )  
 	 {  
 	 	 r e t u r n   0 ;  
 	 }  
  
 	 i f   ( p r i c e   < =   0 )  
 	 {  
 	 	 P r i n t ( " A l i g n T a k e P r o f i t ( )   e r r o r :   N o   p r i c e   e n t e r e d " ) ;  
  
 	 	 r e t u r n   - 1 ;  
 	 }  
  
 	 d o u b l e   p o i n t   =   S y m b o l I n f o D o u b l e ( s y m b o l ,   S Y M B O L _ P O I N T ) ;  
 	 i n t   d i g i t s       =   ( i n t ) S y m b o l I n f o I n t e g e r ( s y m b o l ,   S Y M B O L _ D I G I T S ) ;  
 	 t p p                     =   t p p   *   P i p V a l u e ( s y m b o l )   *   p o i n t ;  
 	  
 	 / / - -   b u y - s e l l   i d e n t i f i e r   - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  
 	 i n t   b s   =   1 ;  
  
 	 i f   (  
 	 	       t y p e   = =   O P _ S E L L  
 	 	 | |   t y p e   = =   O P _ S E L L S T O P  
 	 	 | |   t y p e   = =   O P _ S E L L L I M I T  
  
 	 	 )  
 	 {  
 	 	 b s   =   - 1 ;  
 	 }  
 	  
 	 / / - -   p r i c e s   t h a t   w i l l   b e   u s e d   - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  
 	 d o u b l e   a s k b i d   =   p r i c e ;  
 	 d o u b l e   b i d a s k   =   p r i c e ;  
 	  
 	 i f   ( t y p e   <   2 )  
 	 {  
 	 	 d o u b l e   a s k   =   S y m b o l I n f o D o u b l e ( s y m b o l ,   S Y M B O L _ A S K ) ;  
 	 	 d o u b l e   b i d   =   S y m b o l I n f o D o u b l e ( s y m b o l ,   S Y M B O L _ B I D ) ;  
 	 	  
 	 	 a s k b i d   =   a s k ;  
 	 	 b i d a s k   =   b i d ;  
  
 	 	 i f   ( b s   <   0 )  
 	 	 {  
 	 	     a s k b i d   =   b i d ;  
 	 	     b i d a s k   =   a s k ;  
 	 	 }  
 	 }  
 	  
 	 / / - -   b u i l d   t p   l e v e l   - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -    
 	 i f   ( t p l   = =   0   & &   t p p   ! =   0 )   { t p l   =   p r i c e ; }  
  
 	 i f   ( t p l   >   0 )   { t p   =   t p l   +   t p p   *   b s ; }  
 	  
 	 i f   ( t p   <   0 )  
 	 {  
 	 	 r e t u r n   - 1 ;  
 	 }  
  
 	 t p     =   N o r m a l i z e D o u b l e ( t p ,   d i g i t s ) ;  
 	 t p o   =   N o r m a l i z e D o u b l e ( t p o ,   d i g i t s ) ;  
  
 	 i f   ( t p   = =   t p o )  
 	 {  
 	 	 r e t u r n   t p ;  
 	 }  
 	  
 	 / / - -   b u i l d   l i m i t   l e v e l s   - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  
 	 d o u b l e   m i n s t o p s   =   ( d o u b l e ) S y m b o l I n f o I n t e g e r ( s y m b o l ,   S Y M B O L _ T R A D E _ S T O P S _ L E V E L ) ;  
  
 	 i f   ( c o n s i d e r _ f r e e z e l e v e l   = =   t r u e )  
 	 {  
 	 	 d o u b l e   f r e e z e l e v e l   =   ( d o u b l e ) S y m b o l I n f o I n t e g e r ( s y m b o l ,   S Y M B O L _ T R A D E _ F R E E Z E _ L E V E L ) ;  
  
 	 	 i f   ( f r e e z e l e v e l   >   m i n s t o p s )   { m i n s t o p s   =   f r e e z e l e v e l ; }  
 	 }  
  
 	 m i n s t o p s   =   N o r m a l i z e D o u b l e ( m i n s t o p s   *   p o i n t , d i g i t s ) ;  
 	  
 	 d o u b l e   t p l i m i t   =   b i d a s k   +   m i n s t o p s   *   b s ;   / /   T P   m i n   p r i c e   l e v e l  
 	  
 	 / / - -   c h e c k   a n d   a l i g n   t p ,   p r i n t   e r r o r s   - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  
 	 / / - -   d o   n o t   d o   i t   w h e n   t h e   s t o p   i s   t h e   s a m e   a s   t h e   o r i g i n a l  
 	 i f   ( t p   >   0   & &   t p   ! =   t p o )  
 	 {  
 	 	 i f   ( ( b s   >   0   & &   t p   <   b i d a s k )   | |   ( b s   <   0   & &   t p   >   b i d a s k ) )  
 	 	 {  
 	 	 	 s t r i n g   a b s t r   =   " " ;  
  
 	 	 	 i f   ( b s   >   0 )   { a b s t r   =   " B i d " ; }   e l s e   { a b s t r   =   " A s k " ; }  
  
 	 	 	 P r i n t (  
 	 	 	 	 " E r r o r :   I n v a l i d   T P   r e q u e s t e d   ( " ,  
 	 	 	 	 D o u b l e T o S t r ( t p ,   d i g i t s ) ,  
 	 	 	 	 "   f o r   " ,   a b s t r ,   "   p r i c e   " ,  
 	 	 	 	 b i d a s k ,  
 	 	 	 	 " ) "  
 	 	 	 ) ;  
  
 	 	 	 r e t u r n   - 1 ;  
 	 	 }  
 	 	 e l s e   i f   ( ( b s   >   0   & &   t p   <   t p l i m i t )   | |   ( b s   <   0   & &   t p   >   t p l i m i t ) )  
 	 	 {  
 	 	 	 i f   ( U S E _ V I R T U A L _ S T O P S )  
 	 	 	 {  
 	 	 	 	 r e t u r n   t p ;  
 	 	 	 }  
  
 	 	 	 P r i n t (  
 	 	 	 	 " W a r n i n g :   T o o   s h o r t   T P   r e q u e s t e d   ( " ,  
 	 	 	 	 D o u b l e T o S t r ( t p ,   d i g i t s ) ,  
 	 	 	 	 "   o r   " ,  
 	 	 	 	 D o u b l e T o S t r ( M a t h A b s ( t p   -   a s k b i d )   /   p o i n t ,   0 ) ,  
 	 	 	 	 "   p o i n t s ) ,   m i n i m u m   w i l l   b e   t a k e n   ( " ,  
 	 	 	 	 D o u b l e T o S t r ( t p l i m i t ,   d i g i t s ) ,  
 	 	 	 	 "   o r   " ,  
 	 	 	 	 D o u b l e T o S t r ( M a t h A b s ( a s k b i d   -   t p l i m i t )   /   p o i n t ,   0 ) ,  
 	 	 	 	 "   p o i n t s ) "  
 	 	 	 ) ;  
  
 	 	 	 t p   =   t p l i m i t ;  
  
 	 	 	 r e t u r n   t p ;  
 	 	 }  
 	 }  
 	  
 	 / /   a l i g n   b y   t h e   t i c k s i z e  
 	 d o u b l e   t i c k s i z e   =   S y m b o l I n f o D o u b l e ( s y m b o l ,   S Y M B O L _ T R A D E _ T I C K _ S I Z E ) ;  
 	 t p   =   M a t h R o u n d ( t p   /   t i c k s i z e )   *   t i c k s i z e ;  
 	  
 	 r e t u r n   t p ;  
 }  
  
 t e m p l a t e < t y p e n a m e   T >  
 b o o l   A r r a y E n s u r e V a l u e ( T   & a r r a y [ ] ,   T   v a l u e )  
 {  
 	 i n t   s i z e       =   A r r a y S i z e ( a r r a y ) ;  
 	  
 	 i f   ( s i z e   >   0 )  
 	 {  
 	 	 i f   ( I n A r r a y ( a r r a y ,   v a l u e ) )  
 	 	 {  
 	 	 	 / /   v a l u e   f o u n d   - >   e x i t  
 	 	 	 r e t u r n   f a l s e ;   / /   n o   v a l u e   a d d e d  
 	 	 }  
 	 }  
 	  
 	 / /   v a l u e   d o e s   n o t   e x i s t s   - >   a d d   i t  
 	 A r r a y R e s i z e ( a r r a y ,   s i z e + 1 ) ;  
 	 a r r a y [ s i z e ]   =   v a l u e ;  
 	 	  
 	 r e t u r n   t r u e ;   / /   v a l u e   a d d e d  
 }  
  
 t e m p l a t e < t y p e n a m e   T >  
 i n t   A r r a y S e a r c h ( T   & a r r a y [ ] ,   T   v a l u e )  
 {  
 	 s t a t i c   i n t   i n d e x ;          
 	 s t a t i c   i n t   s i z e ;  
 	  
 	 i n d e x   =   - 1 ;  
 	 s i z e     =   A r r a y S i z e ( a r r a y ) ;  
  
 	 f o r   ( i n t   i = 0 ;   i < s i z e ;   i + + )  
 	 {  
 	 	 i f   ( a r r a y [ i ]   = =   v a l u e )  
 	 	 {  
 	 	 	 i n d e x   =   i ;  
 	 	 	 b r e a k ;  
 	 	 }      
 	 }  
  
       r e t u r n   i n d e x ;  
 }  
  
 t e m p l a t e < t y p e n a m e   T >  
 b o o l   A r r a y S t r i p K e y ( T   & a r r a y [ ] ,   i n t   k e y )  
 {  
 	 i n t   x         =   0 ;  
 	 i n t   s i z e   =   A r r a y S i z e ( a r r a y ) ;  
 	  
 	 f o r   ( i n t   i = 0 ;   i < s i z e ;   i + + )  
 	 {  
 	 	 i f   ( i   ! =   k e y )  
 	 	 {  
 	 	 	 a r r a y [ x ]   =   a r r a y [ i ] ;  
 	 	 	 x + + ;  
 	 	 }  
 	 }  
 	 	  
 	 i f   ( x   <   s i z e )  
 	 {  
 	 	 A r r a y R e s i z e ( a r r a y ,   x ) ;  
 	 	  
 	 	 r e t u r n   t r u e ;   / /   s t r i p p e d  
 	 }  
 	  
 	 r e t u r n   f a l s e ;   / /   n o t   s t r i p p e d  
 }  
  
 t e m p l a t e < t y p e n a m e   T >  
 b o o l   A r r a y S t r i p V a l u e ( T   & a r r a y [ ] ,   T   v a l u e )  
 {  
 	 i n t   x         =   0 ;  
 	 i n t   s i z e   =   A r r a y S i z e ( a r r a y ) ;  
 	  
 	 f o r   ( i n t   i = 0 ;   i < s i z e ;   i + + )  
 	 {  
 	 	 i f   ( a r r a y [ i ]   ! =   v a l u e )  
 	 	 {  
 	 	 	 a r r a y [ x ]   =   a r r a y [ i ] ;  
 	 	 	 x + + ;  
 	 	 }  
 	 }  
 	  
 	 i f   ( x   <   s i z e )  
 	 {  
 	 	 A r r a y R e s i z e ( a r r a y ,   x ) ;  
 	 	  
 	 	 r e t u r n   t r u e ;   / /   s t r i p p e d  
 	 }  
 	  
 	 r e t u r n   f a l s e ;   / /   n o t   s t r i p p e d  
 }  
  
 d o u b l e   B e t 1 3 2 6 ( i n t   g r o u p ,   s t r i n g   s y m b o l ,   d o u b l e   i n i t i a l _ l o t s ,   b o o l   r e v e r s e = f a l s e )  
 {      
       i n t   p o s = 0 ;  
       i n t   t o t a l = 0 ;  
       d o u b l e   l o t s = 0 ;  
       d o u b l e   p r o f i t = 0 ;  
       i n t   p r o f i t _ o r _ l o s s = 0 ;   / /   0   -   u n k n o w n ,   1   -   p r o f i t ,   - 1   -   l o s s  
        
       / / - -   t r y   t o   g e t   l a s t   l o t   s i z e   f r o m   r u n n i n g   t r a d e s  
       t o t a l = O r d e r s T o t a l ( ) ;  
       f o r   ( p o s = t o t a l - 1 ;   p o s > = 0 ;   p o s - - )  
       {  
             i f   ( ! O r d e r S e l e c t ( p o s ,   S E L E C T _ B Y _ P O S ,   M O D E _ T R A D E S ) )   { c o n t i n u e ; }  
             i f   ( O r d e r M a g i c N u m b e r ( )   ! =   M a g i c S t a r t + g r o u p )   { c o n t i n u e ; }  
             i f   ( O r d e r S y m b o l ( )   ! =   s y m b o l )   { c o n t i n u e ; }  
             i f   ( T i m e C u r r e n t ( )   -   O r d e r O p e n T i m e ( )   <   3 )   { c o n t i n u e ; }  
 	 	 i f   ( O r d e r E x p i r a t i o n ( )   >   0   & &   O r d e r E x p i r a t i o n ( )   < =   O r d e r C l o s e T i m e ( ) )   { c o n t i n u e ; }   / /   n o   e x p i r e d   p o  
              
             i f   ( l o t s = = 0 )   {  
                   l o t s = O r d e r L o t s ( ) ;  
             }  
              
             p r o f i t   =   O r d e r C l o s e P r i c e ( ) - O r d e r O p e n P r i c e ( ) ;  
             p r o f i t   =   N o r m a l i z e D o u b l e ( p r o f i t ,   S y m b o l D i g i t s ( O r d e r S y m b o l ( ) ) ) ;  
             i f   ( I s O r d e r T y p e S e l l ( ) )   { p r o f i t   =   - 1 * p r o f i t ; }  
             i f   ( p r o f i t   = =   0 )   {  
                   r e t u r n ( l o t s ) ;  
             }  
              
             i f   ( p r o f i t < 0 )   { p r o f i t _ o r _ l o s s = - 1 ; }  
             e l s e   { p r o f i t _ o r _ l o s s = 1 ; }  
              
             b r e a k ;  
       }  
        
       / / - -   i f   n o   r u n n i n g   t r a d e   w a s   f o u n d ,   s e a r c h   i n   h i s t o r y   t r a d e s  
       i f   ( l o t s = = 0 )  
       {  
             t o t a l = O r d e r s H i s t o r y T o t a l ( ) ;  
             f o r   ( p o s = t o t a l - 1 ;   p o s > = 0 ;   p o s - - )  
             {  
                   i f ( ! O r d e r S e l e c t ( p o s ,   S E L E C T _ B Y _ P O S ,   M O D E _ H I S T O R Y ) )   { c o n t i n u e ; }  
                   i f   ( O r d e r M a g i c N u m b e r ( )   ! =   M a g i c S t a r t + g r o u p )   { c o n t i n u e ; }  
                   i f   ( O r d e r S y m b o l ( )   ! =   s y m b o l )   { c o n t i n u e ; }  
 	 	 	 i f   ( O r d e r T y p e ( )   >   O P _ S E L L )   { c o n t i n u e ; }   / /   n o   p o  
                    
                   i f   ( l o t s = = 0 )   {  
                         l o t s = O r d e r L o t s ( ) ;  
                   }  
                    
                   p r o f i t   =   O r d e r C l o s e P r i c e ( ) - O r d e r O p e n P r i c e ( ) ;  
                   p r o f i t   =   N o r m a l i z e D o u b l e ( p r o f i t ,   S y m b o l D i g i t s ( O r d e r S y m b o l ( ) ) ) ;  
                   i f   ( I s O r d e r T y p e S e l l ( ) )   { p r o f i t   =   - 1 * p r o f i t ; }  
                   i f   ( p r o f i t   = =   0 )   {  
                         r e t u r n ( l o t s ) ;  
                   }  
                    
                   i f   ( p r o f i t < 0 )   { p r o f i t _ o r _ l o s s = - 1 ; }  
                   e l s e   { p r o f i t _ o r _ l o s s = 1 ; }  
                    
                   b r e a k ;  
             }  
       }  
        
       / / - -  
       i f   ( i n i t i a l _ l o t s   <   M a r k e t I n f o ( s y m b o l , M O D E _ M I N L O T ) )   {  
             i n i t i a l _ l o t s   =   M a r k e t I n f o ( s y m b o l , M O D E _ M I N L O T ) ;      
       }  
  
       i f   ( l o t s = = 0 )   { l o t s   =   i n i t i a l _ l o t s ; }  
       e l s e  
       {  
             i f   ( ( r e v e r s e = = f a l s e   & &   p r o f i t _ o r _ l o s s = = 1 )   | |   ( r e v e r s e = = t r u e   & &   p r o f i t _ o r _ l o s s = = - 1 ) )  
             {  
                   d o u b l e   d i v   =   l o t s / i n i t i a l _ l o t s ;  
                    
                   i f   ( d i v   <   1 . 5 )   { l o t s   =   i n i t i a l _ l o t s * 3 ; }  
                   e l s e   i f   ( d i v   <   2 . 5 )   { l o t s   =   i n i t i a l _ l o t s * 6 ; }  
                   e l s e   i f   ( d i v   <   3 . 5 )   { l o t s   =   i n i t i a l _ l o t s * 2 ; }  
                   e l s e   { l o t s   =   i n i t i a l _ l o t s ; }  
             }  
             e l s e   {  
                   l o t s   =   i n i t i a l _ l o t s ;  
             }  
       }  
        
       r e t u r n   l o t s ;  
 }  
  
 d o u b l e   B e t D a l e m b e r t ( i n t   g r o u p ,   s t r i n g   s y m b o l ,   d o u b l e   i n i t i a l _ l o t s ,   d o u b l e   r e v e r s e = f a l s e )  
 {      
       i n t   p o s = 0 ;  
       i n t   t o t a l = 0 ;  
       d o u b l e   l o t s = 0 ;  
       d o u b l e   p r o f i t = 0 ;  
       i n t   p r o f i t _ o r _ l o s s = 0 ;   / /   0   -   u n k n o w n ,   1   -   p r o f i t ,   - 1   -   l o s s  
        
       / / - -   t r y   t o   g e t   l a s t   l o t   s i z e   f r o m   r u n n i n g   t r a d e s  
       t o t a l = O r d e r s T o t a l ( ) ;  
       f o r   ( p o s = t o t a l - 1 ;   p o s > = 0 ;   p o s - - )  
       {  
             i f   ( ! O r d e r S e l e c t ( p o s ,   S E L E C T _ B Y _ P O S ,   M O D E _ T R A D E S ) )   { c o n t i n u e ; }  
             i f   ( O r d e r M a g i c N u m b e r ( )   ! =   M a g i c S t a r t + g r o u p )   { c o n t i n u e ; }  
             i f   ( O r d e r S y m b o l ( )   ! =   s y m b o l )   { c o n t i n u e ; }  
             i f   ( T i m e C u r r e n t ( )   -   O r d e r O p e n T i m e ( )   <   3 )   { c o n t i n u e ; }  
 	 	 i f   ( O r d e r E x p i r a t i o n ( )   >   0   & &   O r d e r E x p i r a t i o n ( )   < =   O r d e r C l o s e T i m e ( ) )   { c o n t i n u e ; }   / /   n o   e x p i r e d   p o  
              
             i f   ( l o t s = = 0 )   {  
                   l o t s = O r d e r L o t s ( ) ;  
             }  
              
             p r o f i t   =   O r d e r C l o s e P r i c e ( ) - O r d e r O p e n P r i c e ( ) ;  
             p r o f i t   =   N o r m a l i z e D o u b l e ( p r o f i t ,   S y m b o l D i g i t s ( O r d e r S y m b o l ( ) ) ) ;  
             i f   ( I s O r d e r T y p e S e l l ( ) )   { p r o f i t   =   - 1 * p r o f i t ; }  
             i f   ( p r o f i t   = =   0 )   {  
                   r e t u r n ( l o t s ) ;  
             }  
              
             i f   ( p r o f i t < 0 )   { p r o f i t _ o r _ l o s s = - 1 ; }  
             e l s e   { p r o f i t _ o r _ l o s s = 1 ; }  
              
             b r e a k ;  
       }  
        
       / / - -   i f   n o   r u n n i n g   t r a d e   w a s   f o u n d ,   s e a r c h   i n   h i s t o r y   t r a d e s  
       i f   ( l o t s = = 0 )  
       {  
             t o t a l = O r d e r s H i s t o r y T o t a l ( ) ;  
             f o r   ( p o s = t o t a l - 1 ;   p o s > = 0 ;   p o s - - )  
             {  
                   i f ( ! O r d e r S e l e c t ( p o s ,   S E L E C T _ B Y _ P O S ,   M O D E _ H I S T O R Y ) )   { c o n t i n u e ; }  
                   i f   ( O r d e r M a g i c N u m b e r ( )   ! =   M a g i c S t a r t + g r o u p )   { c o n t i n u e ; }  
                   i f   ( O r d e r S y m b o l ( )   ! =   s y m b o l )   { c o n t i n u e ; }  
 	 	 	 i f   ( O r d e r T y p e ( )   >   O P _ S E L L )   { c o n t i n u e ; }   / /   n o   p o  
                    
                   i f   ( l o t s = = 0 )   {  
                         l o t s = O r d e r L o t s ( ) ;  
                   }  
                    
                   p r o f i t   =   O r d e r C l o s e P r i c e ( ) - O r d e r O p e n P r i c e ( ) ;  
                   p r o f i t   =   N o r m a l i z e D o u b l e ( p r o f i t ,   S y m b o l D i g i t s ( O r d e r S y m b o l ( ) ) ) ;  
                   i f   ( I s O r d e r T y p e S e l l ( ) )   { p r o f i t   =   - 1 * p r o f i t ; }  
                   i f   ( p r o f i t   = =   0 )   {  
                         r e t u r n ( l o t s ) ;  
                   }  
                    
                   i f   ( p r o f i t < 0 )   { p r o f i t _ o r _ l o s s = - 1 ; }  
                   e l s e   { p r o f i t _ o r _ l o s s = 1 ; }  
                    
                   b r e a k ;  
             }  
       }  
        
       / / - -  
       i f   ( i n i t i a l _ l o t s   <   M a r k e t I n f o ( s y m b o l , M O D E _ M I N L O T ) )   {  
             i n i t i a l _ l o t s   =   M a r k e t I n f o ( s y m b o l , M O D E _ M I N L O T ) ;      
       }  
  
       i f   ( l o t s = = 0 )   { l o t s   =   i n i t i a l _ l o t s ; }  
       e l s e  
       {  
             i f   ( ( r e v e r s e = = 0   & &   p r o f i t _ o r _ l o s s = = 1 )   | |   ( r e v e r s e = = 1   & &   p r o f i t _ o r _ l o s s = = - 1 ) )  
             {  
                   l o t s   =   l o t s   -   i n i t i a l _ l o t s ;  
                   i f   ( l o t s   <   i n i t i a l _ l o t s )   { l o t s   =   i n i t i a l _ l o t s ; }  
             }  
             e l s e   {  
                   l o t s   =   l o t s   +   i n i t i a l _ l o t s ;  
             }  
       }  
        
       r e t u r n   l o t s ;  
 }  
  
 d o u b l e   B e t F i b o n a c c i (  
       i n t   g r o u p ,  
       s t r i n g   s y m b o l ,  
       d o u b l e   i n i t i a l _ l o t s  
       )  
 {  
       i n t   p o s = 0 ;  
       i n t   t o t a l = 0 ;  
       d o u b l e   l o t s = 0 ;  
       d o u b l e   p r o f i t = 0 ;  
       i n t   p r o f i t _ o r _ l o s s = 0 ;   / /   0   -   u n k n o w n ,   1   -   p r o f i t ,   - 1   -   l o s s  
        
       / / - -   t r y   t o   g e t   l a s t   l o t   s i z e   f r o m   r u n n i n g   t r a d e s  
       t o t a l = O r d e r s T o t a l ( ) ;  
       f o r   ( p o s = t o t a l - 1 ;   p o s > = 0 ;   p o s - - )  
       {  
             i f   ( ! O r d e r S e l e c t ( p o s ,   S E L E C T _ B Y _ P O S ,   M O D E _ T R A D E S ) )   { c o n t i n u e ; }  
             i f   ( O r d e r M a g i c N u m b e r ( )   ! =   M a g i c S t a r t + g r o u p )   { c o n t i n u e ; }  
             i f   ( O r d e r S y m b o l ( )   ! =   s y m b o l )   { c o n t i n u e ; }  
             i f   ( T i m e C u r r e n t ( )   -   O r d e r O p e n T i m e ( )   <   3 )   { c o n t i n u e ; }  
 	 	 i f   ( O r d e r E x p i r a t i o n ( )   >   0   & &   O r d e r E x p i r a t i o n ( )   < =   O r d e r C l o s e T i m e ( ) )   { c o n t i n u e ; }   / /   n o   e x p i r e d   p o  
              
             i f   ( l o t s = = 0 )   {  
                   l o t s = O r d e r L o t s ( ) ;  
             }  
              
             p r o f i t   =   O r d e r C l o s e P r i c e ( ) - O r d e r O p e n P r i c e ( ) ;  
             p r o f i t   =   N o r m a l i z e D o u b l e ( p r o f i t ,   S y m b o l D i g i t s ( O r d e r S y m b o l ( ) ) ) ;  
             i f   ( I s O r d e r T y p e S e l l ( ) )   { p r o f i t   =   - 1 * p r o f i t ; }  
             i f   ( p r o f i t   = =   0 )   {  
                   r e t u r n ( l o t s ) ;  
             }  
              
             i f   ( p r o f i t < 0 )   { p r o f i t _ o r _ l o s s = - 1 ; }  
             e l s e   { p r o f i t _ o r _ l o s s = 1 ; }  
              
             b r e a k ;  
       }  
        
       / / - -   i f   n o   r u n n i n g   t r a d e   w a s   f o u n d ,   s e a r c h   i n   h i s t o r y   t r a d e s  
       i f   ( l o t s = = 0 )  
       {  
             t o t a l = O r d e r s H i s t o r y T o t a l ( ) ;  
             f o r   ( p o s = t o t a l - 1 ;   p o s > = 0 ;   p o s - - )  
             {  
                   i f ( ! O r d e r S e l e c t ( p o s ,   S E L E C T _ B Y _ P O S ,   M O D E _ H I S T O R Y ) )   { c o n t i n u e ; }  
                   i f   ( O r d e r M a g i c N u m b e r ( )   ! =   M a g i c S t a r t + g r o u p )   { c o n t i n u e ; }  
                   i f   ( O r d e r S y m b o l ( )   ! =   s y m b o l )   { c o n t i n u e ; }  
 	 	 	 i f   ( O r d e r T y p e ( )   >   O P _ S E L L )   { c o n t i n u e ; }   / /   n o   p o  
                    
                   i f   ( l o t s = = 0 )   {  
                         l o t s = O r d e r L o t s ( ) ;  
                   }  
                    
                   p r o f i t   =   O r d e r C l o s e P r i c e ( ) - O r d e r O p e n P r i c e ( ) ;  
                   p r o f i t   =   N o r m a l i z e D o u b l e ( p r o f i t ,   S y m b o l D i g i t s ( O r d e r S y m b o l ( ) ) ) ;  
                   i f   ( I s O r d e r T y p e S e l l ( ) )   { p r o f i t   =   - 1 * p r o f i t ; }  
                   i f   ( p r o f i t   = =   0 )   {  
                         r e t u r n ( l o t s ) ;  
                   }  
                    
                   i f   ( p r o f i t < 0 )   { p r o f i t _ o r _ l o s s = - 1 ; }  
                   e l s e   { p r o f i t _ o r _ l o s s = 1 ; }  
                    
                   b r e a k ;  
             }  
       }  
  
       / / - -  
       i f   ( i n i t i a l _ l o t s   <   M a r k e t I n f o ( s y m b o l , M O D E _ M I N L O T ) )   {  
             i n i t i a l _ l o t s   =   M a r k e t I n f o ( s y m b o l , M O D E _ M I N L O T ) ;      
       }  
  
       i f   ( l o t s = = 0 )   { l o t s   =   i n i t i a l _ l o t s ; }  
       e l s e  
       {      
             i n t   f i b o 1 = 1 ,   f i b o 2 = 0 ,   f i b o 3 = 0 ,   f i b o 4 = 0 ;  
             d o u b l e   d i v   =   l o t s / i n i t i a l _ l o t s ;  
              
             i f   ( d i v < = 0 )   { d i v = 1 ; }  
  
             w h i l e ( t r u e )  
             {  
                   f i b o 1 = f i b o 1 + f i b o 2 ;  
                   f i b o 3 = f i b o 2 ;  
                   f i b o 2 = f i b o 1 - f i b o 2 ;  
                   f i b o 4 = f i b o 2 - f i b o 3 ;  
                   i f   ( f i b o 1   >   N o r m a l i z e D o u b l e ( d i v ,   2 ) )   { b r e a k ; }  
             }  
             / / P r i n t ( " ( " + f i b o 1   +   " + "   +   f i b o 2 + " + " + f i b o 3 + " )   >   " + d i v ) ;  
             i f   ( p r o f i t _ o r _ l o s s = = 1 )  
             {  
                   i f   ( f i b o 4 < = 0 )   { f i b o 4 = 1 ; }  
                   / / P r i n t ( " P r o f i t   " + l o t s + " * " + f i b o 4 ) ;  
                   l o t s = i n i t i a l _ l o t s * ( f i b o 4 ) ;  
             }  
             e l s e   {  
                   / / P r i n t ( " L o s s   " + l o t s + " * " + f i b o 1 + " + " + f i b o 2 ) ;  
                   l o t s = i n i t i a l _ l o t s * ( f i b o 1 ) ;  
             }  
       }  
        
       l o t s = N o r m a l i z e D o u b l e ( l o t s ,   2 ) ;  
       r e t u r n   l o t s ;  
 }  
  
 d o u b l e   B e t L a b o u c h e r e ( i n t   g r o u p ,   s t r i n g   s y m b o l ,   d o u b l e   i n i t i a l _ l o t s ,   s t r i n g   l i s t _ o f _ n u m b e r s ,   d o u b l e   r e v e r s e = f a l s e )  
 {        
       i n t   p o s = 0 ;  
       i n t   t o t a l = 0 ;  
       d o u b l e   l o t s = 0 ;  
       d o u b l e   p r o f i t = 0 ;  
       i n t   p r o f i t _ o r _ l o s s = 0 ;   / /   0   -   u n k n o w n ,   1   -   p r o f i t ,   - 1   -   l o s s  
        
       / / - -   t r y   t o   g e t   l a s t   l o t   s i z e   f r o m   r u n n i n g   t r a d e s  
       t o t a l = O r d e r s T o t a l ( ) ;  
       f o r   ( p o s = t o t a l - 1 ;   p o s > = 0 ;   p o s - - )  
       {  
             i f   ( ! O r d e r S e l e c t ( p o s ,   S E L E C T _ B Y _ P O S ,   M O D E _ T R A D E S ) )   { c o n t i n u e ; }  
             i f   ( O r d e r M a g i c N u m b e r ( )   ! =   M a g i c S t a r t + g r o u p )   { c o n t i n u e ; }  
             i f   ( O r d e r S y m b o l ( )   ! =   s y m b o l )   { c o n t i n u e ; }  
             i f   ( T i m e C u r r e n t ( )   -   O r d e r O p e n T i m e ( )   <   3 )   { c o n t i n u e ; }  
 	 	 i f   ( O r d e r E x p i r a t i o n ( )   >   0   & &   O r d e r E x p i r a t i o n ( )   < =   O r d e r C l o s e T i m e ( ) )   { c o n t i n u e ; }   / /   n o   e x p i r e d   p o  
              
             i f   ( l o t s = = 0 )   {  
                   l o t s = O r d e r L o t s ( ) ;  
             }  
              
             p r o f i t   =   O r d e r C l o s e P r i c e ( ) - O r d e r O p e n P r i c e ( ) ;  
             p r o f i t   =   N o r m a l i z e D o u b l e ( p r o f i t ,   S y m b o l D i g i t s ( O r d e r S y m b o l ( ) ) ) ;  
             i f   ( I s O r d e r T y p e S e l l ( ) )   { p r o f i t   =   - 1 * p r o f i t ; }  
             i f   ( p r o f i t   = =   0 )   {  
                   r e t u r n ( l o t s ) ;  
             }  
              
             i f   ( p r o f i t < 0 )   { p r o f i t _ o r _ l o s s = - 1 ; }  
             e l s e   { p r o f i t _ o r _ l o s s = 1 ; }  
              
             b r e a k ;  
       }  
        
       / / - -   i f   n o   r u n n i n g   t r a d e   w a s   f o u n d ,   s e a r c h   i n   h i s t o r y   t r a d e s  
       i f   ( l o t s = = 0 )  
       {  
             t o t a l = O r d e r s H i s t o r y T o t a l ( ) ;  
             f o r   ( p o s = t o t a l - 1 ;   p o s > = 0 ;   p o s - - )  
             {  
                   i f ( ! O r d e r S e l e c t ( p o s ,   S E L E C T _ B Y _ P O S ,   M O D E _ H I S T O R Y ) )   { c o n t i n u e ; }  
                   i f   ( O r d e r M a g i c N u m b e r ( )   ! =   M a g i c S t a r t + g r o u p )   { c o n t i n u e ; }  
                   i f   ( O r d e r S y m b o l ( )   ! =   s y m b o l )   { c o n t i n u e ; }  
 	 	 	 i f   ( O r d e r T y p e ( )   >   O P _ S E L L )   { c o n t i n u e ; }   / /   n o   p o  
                    
                   i f   ( l o t s = = 0 )   {  
                         l o t s = O r d e r L o t s ( ) ;  
                   }  
                    
                   p r o f i t   =   O r d e r C l o s e P r i c e ( ) - O r d e r O p e n P r i c e ( ) ;  
                   p r o f i t   =   N o r m a l i z e D o u b l e ( p r o f i t ,   S y m b o l D i g i t s ( O r d e r S y m b o l ( ) ) ) ;  
                   i f   ( I s O r d e r T y p e S e l l ( ) )   { p r o f i t   =   - 1 * p r o f i t ; }  
                   i f   ( p r o f i t   = =   0 )   {  
                         r e t u r n ( l o t s ) ;  
                   }  
  
                   i f   ( p r o f i t < 0 )   { p r o f i t _ o r _ l o s s = - 1 ; }  
                   e l s e   { p r o f i t _ o r _ l o s s = 1 ; }  
                    
                   b r e a k ;  
             }  
       }  
        
       / / - -   L a b o u c h e r e   s t u f f  
       s t a t i c   i n t   m e m _ g r o u p [ ] ;  
       s t a t i c   s t r i n g   m e m _ l i s t [ ] ;  
       s t a t i c   i n t   m e m _ t i c k e t [ ] ;  
       i n t   s t a r t _ a g a i n = f a l s e ;  
        
       / / -   g e t   t h e   l i s t   o f   n u m b e r s   a s   i t   i s   s t o r e d   i n   t h e   m e m o r y ,   o r   s t o r e   i t  
       i n t   i d = A r r a y S e a r c h ( m e m _ g r o u p ,   g r o u p ) ;  
       i f   ( i d   = =   - 1 )   {  
             s t a r t _ a g a i n = t r u e ;  
             i f   ( l i s t _ o f _ n u m b e r s = = " " )   { l i s t _ o f _ n u m b e r s = " 1 " ; }  
             i d   =   A r r a y S i z e ( m e m _ g r o u p ) ;  
             A r r a y R e s i z e ( m e m _ g r o u p ,   i d + 1 ,   i d + 1 ) ;  
             A r r a y R e s i z e ( m e m _ l i s t ,   i d + 1 ,   i d + 1 ) ;  
             A r r a y R e s i z e ( m e m _ t i c k e t ,   i d + 1 ,   i d + 1 ) ;  
             m e m _ g r o u p [ i d ] = g r o u p ;  
             m e m _ l i s t [ i d ] = l i s t _ o f _ n u m b e r s ;  
       }  
        
       i f   ( m e m _ t i c k e t [ i d ] = = O r d e r T i c k e t ( ) )   {  
             / /   t h e   l a s t   k n o w n   t i c k e t   ( m e m _ t i c k e t [ i d ] )   s h o u l d   b e   d i f f e r e n t   t h a n   O d e r T i c k e t ( )   n o r m a l l y  
             / /   w h e n   f a i l e d   t o   c r e a t e   a   n e w   t r a d e   -   t h e   l a s t   t i c k e t   r e m a i n s   t h e   s a m e  
             / /   s o   w e   n e e d   t o   r e s e t  
             m e m _ l i s t [ i d ] = l i s t _ o f _ n u m b e r s ;  
       }  
       m e m _ t i c k e t [ i d ] = O r d e r T i c k e t ( ) ;  
        
       / / -   n o w   t u r n   t h e   s t r i n g   i n t o   i n t e g e r   a r r a y  
       i n t   l i s t [ ] ;  
       s t r i n g   l i s t S [ ] ;  
       S t r i n g E x p l o d e ( " , " ,   m e m _ l i s t [ i d ] ,   l i s t S ) ;  
       A r r a y R e s i z e ( l i s t ,   A r r a y S i z e ( l i s t S ) ) ;  
       f o r   ( i n t   s = 0 ;   s < A r r a y S i z e ( l i s t S ) ;   s + + )   {  
             l i s t [ s ] = ( i n t ) S t r i n g T o I n t e g e r ( S t r i n g T r i m ( l i s t S [ s ] ) ) ;      
       }  
  
       / / - -    
       i n t   s i z e   =   A r r a y S i z e ( l i s t ) ;  
  
       i f   ( i n i t i a l _ l o t s   <   M a r k e t I n f o ( s y m b o l , M O D E _ M I N L O T ) )   {  
             i n i t i a l _ l o t s   =   M a r k e t I n f o ( s y m b o l , M O D E _ M I N L O T ) ;      
       }  
  
       i f   ( l o t s = = 0 )   {  
             s t a r t _ a g a i n = t r u e ;  
       }  
        
       i f   ( s t a r t _ a g a i n = = t r u e )  
       {  
             i f   ( s i z e = = 1 )   {  
                   l o t s   =   i n i t i a l _ l o t s * l i s t [ 0 ] ;  
             }   e l s e   {  
                   l o t s   =   i n i t i a l _ l o t s * ( l i s t [ 0 ] + l i s t [ s i z e - 1 ] ) ;  
             }  
       }  
       e l s e    
       {  
             i f   ( ( r e v e r s e = = 0   & &   p r o f i t _ o r _ l o s s = = 1 )   | |   ( r e v e r s e = = 1   & &   p r o f i t _ o r _ l o s s = = - 1 ) )  
             {  
                   i f   ( s i z e = = 1 )   {  
                         l o t s = i n i t i a l _ l o t s * l i s t [ 0 ] ;  
                         A r r a y R e s i z e ( l i s t ,   0 ) ;  
                   }  
                   e l s e   i f   ( s i z e = = 2 )   {  
                         l o t s   =   i n i t i a l _ l o t s * ( l i s t [ 0 ] + l i s t [ 1 ] ) ;  
                         A r r a y R e s i z e ( l i s t ,   0 ) ;  
                   }  
                   e l s e   i f   ( s i z e > 2 )   {  
                         l o t s   =   i n i t i a l _ l o t s * ( l i s t [ 0 ] + l i s t [ s i z e - 1 ] ) ;  
                         / /   C a n c e l   f i r s t   a n d   l a s t   n u m b e r s   i n   o u r   l i s t  
                         / /   s h i f t   a r r a y   1   s t e p   l e f t  
                         f o r ( p o s = 0 ;   p o s < s i z e - 1 ;   p o s + + )   {  
                               l i s t [ p o s ] = l i s t [ p o s + 1 ] ;  
                         }  
                         A r r a y R e s i z e ( l i s t , A r r a y S i z e ( l i s t ) - 2 ) ;   / /   r e m o v e   l a s t   2   e l e m e n t s 	 	  
                   }  
                   i f   ( l o t s   <   i n i t i a l _ l o t s )   { l o t s   =   i n i t i a l _ l o t s ; }  
             }  
             e l s e   {  
                   i f   ( s i z e > 1 )  
                   {  
                         A r r a y R e s i z e ( l i s t ,   s i z e + 1 ) ;  
                         l i s t [ s i z e ] = l i s t [ 0 ] + l i s t [ s i z e - 1 ] ;  
                         l o t s   =   i n i t i a l _ l o t s * ( l i s t [ 0 ] + l i s t [ s i z e ] ) ;  
                   }   e l s e   {  
                         l o t s   =   i n i t i a l _ l o t s * l i s t [ 0 ] ;  
                   }  
                   i f   ( l o t s   <   i n i t i a l _ l o t s )   { l o t s   =   i n i t i a l _ l o t s ; }  
             }  
  
       }  
        
       P r i n t ( " L a b o u c h e r e   ( f o r   g r o u p   " + ( s t r i n g ) i d + " )   c u r r e n t   l i s t   o f   n u m b e r s : " + S t r i n g I m p l o d e ( " , " ,   l i s t ) ) ;  
       s i z e = A r r a y S i z e ( l i s t ) ;  
       i f   ( s i z e = = 0 )   {  
             A r r a y S t r i p K e y ( m e m _ g r o u p ,   i d ) ;  
             A r r a y S t r i p K e y ( m e m _ l i s t ,   i d ) ;  
             A r r a y S t r i p K e y ( m e m _ t i c k e t ,   i d ) ;  
       }   e l s e   {  
             m e m _ l i s t [ i d ] = S t r i n g I m p l o d e ( " , " ,   l i s t ) ;  
       }  
  
       r e t u r n   l o t s ;  
 }  
  
 d o u b l e   B e t M a r t i n g a l e (  
       i n t   g r o u p ,  
       s t r i n g   s y m b o l ,  
       d o u b l e   i n i t i a l _ l o t s ,  
       d o u b l e   m u l t i p l y _ o n _ l o s s ,  
       d o u b l e   m u l t i p l y _ o n _ p r o f i t ,  
       d o u b l e   a d d _ o n _ l o s s ,  
       d o u b l e   a d d _ o n _ p r o f i t ,  
       i n t   r e s e t _ o n _ l o s s ,  
       i n t   r e s e t _ o n _ p r o f i t  
       )  
 {  
       i n t   p o s = 0 ;  
 	 i n t   t o t a l = 0 ;  
       d o u b l e   l o t s = 0 ;  
       d o u b l e   p r o f i t = 0 ;  
       i n t   p r o f i t _ o r _ l o s s = 0 ;   / /   0   -   u n k n o w n ,   1   -   p r o f i t ,   - 1   -   l o s s  
       i n t   i n _ a _ r o w = 0 ;  
        
       / / - -   t r y   t o   g e t   l a s t   l o t   s i z e   f r o m   r u n n i n g   t r a d e s  
       t o t a l = O r d e r s T o t a l ( ) ;  
       f o r   ( p o s = t o t a l - 1 ;   p o s > = 0 ;   p o s - - )  
       {  
             i f   ( ! O r d e r S e l e c t ( p o s ,   S E L E C T _ B Y _ P O S ,   M O D E _ T R A D E S ) )   { c o n t i n u e ; }  
             i f   ( O r d e r M a g i c N u m b e r ( )   ! =   M a g i c S t a r t + g r o u p )   { c o n t i n u e ; }  
             i f   ( O r d e r S y m b o l ( )   ! =   s y m b o l )   { c o n t i n u e ; }  
             i f   ( T i m e C u r r e n t ( )   -   O r d e r O p e n T i m e ( )   <   3 )   { c o n t i n u e ; }  
 	 	 i f   ( O r d e r E x p i r a t i o n ( )   >   0   & &   O r d e r E x p i r a t i o n ( )   < =   O r d e r C l o s e T i m e ( ) )   { c o n t i n u e ; }   / /   n o   e x p i r e d   p o  
  
             i f   ( l o t s = = 0 )   {  
                   l o t s = O r d e r L o t s ( ) ;  
             }  
              
             p r o f i t   =   O r d e r C l o s e P r i c e ( ) - O r d e r O p e n P r i c e ( ) ;  
             p r o f i t   =   N o r m a l i z e D o u b l e ( p r o f i t ,   S y m b o l D i g i t s ( O r d e r S y m b o l ( ) ) ) ;  
             i f   ( I s O r d e r T y p e S e l l ( ) )   { p r o f i t   =   - 1 * p r o f i t ; }  
             i f   ( p r o f i t   = =   0 )   {  
                   r e t u r n ( l o t s ) ;  
             }  
              
             i f   ( p r o f i t _ o r _ l o s s   = =   0 )  
             {  
                    
                   i f   ( p r o f i t < 0 )   { p r o f i t _ o r _ l o s s = - 1 ; }  
                   e l s e   { p r o f i t _ o r _ l o s s = 1 ; }  
             }  
             e l s e   {  
                             i f   ( p r o f i t _ o r _ l o s s = = 1   & &   p r o f i t < 0 )   { b r e a k ; }  
                   e l s e   i f   ( p r o f i t _ o r _ l o s s = = - 1   & &   p r o f i t > = 0 )   { b r e a k ; }  
             }  
              
             i n _ a _ r o w + + ;  
       }  
        
       / / - -   i f   n o   r u n n i n g   t r a d e   w a s   f o u n d ,   s e a r c h   i n   h i s t o r y   t r a d e s  
       i f   ( l o t s = = 0 )  
       {  
             t o t a l = O r d e r s H i s t o r y T o t a l ( ) ;  
             f o r   ( p o s = t o t a l - 1 ;   p o s > = 0 ;   p o s - - )  
             {  
                   i f ( ! O r d e r S e l e c t ( p o s ,   S E L E C T _ B Y _ P O S ,   M O D E _ H I S T O R Y ) )   { c o n t i n u e ; }  
                   i f   ( O r d e r M a g i c N u m b e r ( )   ! =   M a g i c S t a r t + g r o u p )   { c o n t i n u e ; }  
                   i f   ( O r d e r S y m b o l ( )   ! =   s y m b o l )   { c o n t i n u e ; }  
 	 	 	 i f   ( O r d e r T y p e ( )   >   O P _ S E L L )   { c o n t i n u e ; }   / /   n o   p o  
                    
                   i f   ( l o t s = = 0 )   {  
                         l o t s = O r d e r L o t s ( ) ;  
                   }  
                    
                   p r o f i t   =   O r d e r C l o s e P r i c e ( ) - O r d e r O p e n P r i c e ( ) ;  
                   p r o f i t   =   N o r m a l i z e D o u b l e ( p r o f i t ,   S y m b o l D i g i t s ( O r d e r S y m b o l ( ) ) ) ;  
                   i f   ( I s O r d e r T y p e S e l l ( ) )   { p r o f i t   =   - 1 * p r o f i t ; }  
                   i f   ( p r o f i t   = =   0 )   {  
                         r e t u r n ( l o t s ) ;  
                   }  
                    
                   i f   ( p r o f i t _ o r _ l o s s   = =   0 )  
                   {  
                         i f   ( p r o f i t < 0 )   { p r o f i t _ o r _ l o s s = - 1 ; }  
                         e l s e   { p r o f i t _ o r _ l o s s = 1 ; }  
                   }  
                   e l s e   {  
                                   i f   ( p r o f i t _ o r _ l o s s = = 1   & &   p r o f i t < 0 )   { b r e a k ; }  
                         e l s e   i f   ( p r o f i t _ o r _ l o s s = = - 1   & &   p r o f i t > = 0 )   { b r e a k ; }  
                   }  
                    
                   i n _ a _ r o w + + ;  
             }  
       }  
  
       / / - -  
       / *  
       i f   ( i n i t i a l _ l o t s   <   M a r k e t I n f o ( s y m b o l , M O D E _ M I N L O T ) )   {  
             i n i t i a l _ l o t s   =   M a r k e t I n f o ( s y m b o l , M O D E _ M I N L O T ) ;      
       } * /  
  
       i f   ( l o t s = = 0 )   { l o t s   =   i n i t i a l _ l o t s ; }  
       e l s e   {  
             i f   ( p r o f i t _ o r _ l o s s = = 1 )  
             {  
                   i f   ( r e s e t _ o n _ p r o f i t > 0   & &   i n _ a _ r o w   > =   r e s e t _ o n _ p r o f i t )   {  
                         l o t s = i n i t i a l _ l o t s ;  
                   }  
                   e l s e   {  
                         i f   ( m u l t i p l y _ o n _ p r o f i t < = 0 )   { m u l t i p l y _ o n _ p r o f i t = 1 ; }  
                         l o t s = ( l o t s * m u l t i p l y _ o n _ p r o f i t )   +   a d d _ o n _ p r o f i t ;  
                   }  
             }  
             e l s e   {  
                   i f   ( r e s e t _ o n _ l o s s > 0   & &   i n _ a _ r o w   > =   r e s e t _ o n _ l o s s )   {  
                         l o t s = i n i t i a l _ l o t s ;      
                   }  
                   e l s e   {  
                         i f   ( m u l t i p l y _ o n _ l o s s < = 0 )   { m u l t i p l y _ o n _ l o s s = 1 ; }  
                         l o t s = ( l o t s * m u l t i p l y _ o n _ l o s s )   +   a d d _ o n _ l o s s ;  
                   }  
             }  
       }  
        
       r e t u r n   l o t s ;  
 }  
  
 d o u b l e   B e t S e q u e n c e ( i n t   g r o u p ,   s t r i n g   s y m b o l ,   d o u b l e   i n i t i a l _ l o t s ,   s t r i n g   s e q u e n c e _ o n _ l o s s ,   s t r i n g   s e q u e n c e _ o n _ p r o f i t ,   b o o l   r e v e r s e = f a l s e )  
 {      
       i n t   p o s = 0 ;  
       i n t   t o t a l = 0 ;  
       d o u b l e   l o t s = 0 ;  
       i n t   s i z e = 0 ;  
       d o u b l e   p r o f i t = 0 ;  
       i n t   p r o f i t _ o r _ l o s s = 0 ;   / /   0   -   u n k n o w n ,   1   -   p r o f i t ,   - 1   -   l o s s  
        
       / / - -   t r y   t o   g e t   l a s t   l o t   s i z e   f r o m   r u n n i n g   t r a d e s  
       t o t a l = O r d e r s T o t a l ( ) ;  
       f o r   ( p o s = t o t a l - 1 ;   p o s > = 0 ;   p o s - - )  
       {  
             i f   ( ! O r d e r S e l e c t ( p o s ,   S E L E C T _ B Y _ P O S ,   M O D E _ T R A D E S ) )   { c o n t i n u e ; }  
             i f   ( O r d e r M a g i c N u m b e r ( )   ! =   M a g i c S t a r t + g r o u p )   { c o n t i n u e ; }  
             i f   ( O r d e r S y m b o l ( )   ! =   s y m b o l )   { c o n t i n u e ; }  
             i f   ( T i m e C u r r e n t ( )   -   O r d e r O p e n T i m e ( )   <   3 )   { c o n t i n u e ; }  
 	 	 i f   ( O r d e r E x p i r a t i o n ( )   >   0   & &   O r d e r E x p i r a t i o n ( )   < =   O r d e r C l o s e T i m e ( ) )   { c o n t i n u e ; }   / /   n o   e x p i r e d   p o  
              
             i f   ( l o t s = = 0 )   {  
                   l o t s = O r d e r L o t s ( ) ;  
             }  
              
             p r o f i t   =   O r d e r C l o s e P r i c e ( ) - O r d e r O p e n P r i c e ( ) ;  
             p r o f i t   =   N o r m a l i z e D o u b l e ( p r o f i t ,   S y m b o l D i g i t s ( O r d e r S y m b o l ( ) ) ) ;  
             i f   ( I s O r d e r T y p e S e l l ( ) )   { p r o f i t   =   - 1 * p r o f i t ; }  
             i f   ( p r o f i t   = =   0 )   {  
                   r e t u r n ( l o t s ) ;  
             }  
              
             i f   ( p r o f i t < 0 )   { p r o f i t _ o r _ l o s s = - 1 ; }  
             e l s e   { p r o f i t _ o r _ l o s s = 1 ; }  
              
             b r e a k ;  
       }  
        
       / / - -   i f   n o   r u n n i n g   t r a d e   w a s   f o u n d ,   s e a r c h   i n   h i s t o r y   t r a d e s  
       i f   ( l o t s = = 0 )  
       {  
             t o t a l = O r d e r s H i s t o r y T o t a l ( ) ;  
             f o r   ( p o s = t o t a l - 1 ;   p o s > = 0 ;   p o s - - )  
             {  
                   i f ( ! O r d e r S e l e c t ( p o s ,   S E L E C T _ B Y _ P O S ,   M O D E _ H I S T O R Y ) )   { c o n t i n u e ; }  
                   i f   ( O r d e r M a g i c N u m b e r ( )   ! =   M a g i c S t a r t + g r o u p )   { c o n t i n u e ; }  
                   i f   ( O r d e r S y m b o l ( )   ! =   s y m b o l )   { c o n t i n u e ; }  
 	 	 	 i f   ( O r d e r T y p e ( )   >   O P _ S E L L )   { c o n t i n u e ; }   / /   n o   p o  
                    
                   i f   ( l o t s = = 0 )   {  
                         l o t s = O r d e r L o t s ( ) ;  
                   }  
                    
                   p r o f i t   =   O r d e r C l o s e P r i c e ( ) - O r d e r O p e n P r i c e ( ) ;  
                   p r o f i t   =   N o r m a l i z e D o u b l e ( p r o f i t ,   S y m b o l D i g i t s ( O r d e r S y m b o l ( ) ) ) ;  
                   i f   ( I s O r d e r T y p e S e l l ( ) )   { p r o f i t   =   - 1 * p r o f i t ; }  
                   i f   ( p r o f i t   = =   0 )   {  
                         r e t u r n ( l o t s ) ;  
                   }  
                    
                   i f   ( p r o f i t < 0 )   { p r o f i t _ o r _ l o s s = - 1 ; }  
                   e l s e   { p r o f i t _ o r _ l o s s = 1 ; }  
                    
                   b r e a k ;  
             }  
       }  
        
       / / - -   S e q u e n c e   s t u f f  
       s t a t i c   i n t   m e m _ g r o u p [ ] ;  
       s t a t i c   s t r i n g   m e m _ l i s t _ l o s s [ ] ;  
       s t a t i c   s t r i n g   m e m _ l i s t _ p r o f i t [ ] ;  
       s t a t i c   i n t   m e m _ t i c k e t [ ] ;  
        
       / / -   g e t   t h e   l i s t   o f   n u m b e r s   a s   i t   i s   s t o r e d   i n   t h e   m e m o r y ,   o r   s t o r e   i t  
       i n t   i d = A r r a y S e a r c h ( m e m _ g r o u p ,   g r o u p ) ;  
       i f   ( i d   = =   - 1 )  
       {  
             i f   ( s e q u e n c e _ o n _ l o s s = = " " )   { s e q u e n c e _ o n _ l o s s = " 1 " ; }  
             i f   ( s e q u e n c e _ o n _ p r o f i t = = " " )   { s e q u e n c e _ o n _ p r o f i t = " 1 " ; }  
             i d   =   A r r a y S i z e ( m e m _ g r o u p ) ;  
             A r r a y R e s i z e ( m e m _ g r o u p ,   i d + 1 ,   i d + 1 ) ;  
             A r r a y R e s i z e ( m e m _ l i s t _ l o s s ,   i d + 1 ,   i d + 1 ) ;  
             A r r a y R e s i z e ( m e m _ l i s t _ p r o f i t ,   i d + 1 ,   i d + 1 ) ;  
             A r r a y R e s i z e ( m e m _ t i c k e t ,   i d + 1 ,   i d + 1 ) ;  
             m e m _ g r o u p [ i d ]                 = g r o u p ;  
             m e m _ l i s t _ l o s s [ i d ]         = s e q u e n c e _ o n _ l o s s ;  
             m e m _ l i s t _ p r o f i t [ i d ]     = s e q u e n c e _ o n _ p r o f i t ;  
       }  
        
       b o o l   l o s s _ r e s e t = f a l s e ;  
       b o o l   p r o f i t _ r e s e t = f a l s e ;  
       i f   ( p r o f i t _ o r _ l o s s = = - 1   & &   m e m _ l i s t _ l o s s [ i d ] = = " " )   {  
             l o s s _ r e s e t = t r u e ;  
             m e m _ l i s t _ p r o f i t [ i d ] = " " ;  
       }  
       i f   ( p r o f i t _ o r _ l o s s = = 1   & &   m e m _ l i s t _ p r o f i t [ i d ] = = " " )   {  
             p r o f i t _ r e s e t = t r u e ;  
             m e m _ l i s t _ l o s s [ i d ] = " " ;  
       }  
        
       i f   ( p r o f i t _ o r _ l o s s = = 1   | |   m e m _ l i s t _ l o s s [ i d ] = = " " )   {  
             m e m _ l i s t _ l o s s [ i d ] = s e q u e n c e _ o n _ l o s s ;  
             i f   ( l o s s _ r e s e t )   { m e m _ l i s t _ l o s s [ i d ] = " 1 , " + m e m _ l i s t _ l o s s [ i d ] ; }  
              
       }  
       i f   ( p r o f i t _ o r _ l o s s = = - 1   | | m e m _ l i s t _ p r o f i t [ i d ] = = " " )   {  
             m e m _ l i s t _ p r o f i t [ i d ] = s e q u e n c e _ o n _ p r o f i t ;  
             i f   ( p r o f i t _ r e s e t )   { m e m _ l i s t _ p r o f i t [ i d ] = " 1 , " + m e m _ l i s t _ p r o f i t [ i d ] ; }  
       }  
        
       i f   ( m e m _ t i c k e t [ i d ] = = O r d e r T i c k e t ( ) )   {  
             / /   t h e   l a s t   k n o w n   t i c k e t   ( m e m _ t i c k e t [ i d ] )   s h o u l d   b e   d i f f e r e n t   t h a n   O d e r T i c k e t ( )   n o r m a l l y  
             / /   w h e n   f a i l e d   t o   c r e a t e   a   n e w   t r a d e   -   t h e   l a s t   t i c k e t   r e m a i n s   t h e   s a m e  
             / /   s o   w e   n e e d   t o   r e s e t  
             m e m _ l i s t _ l o s s [ i d ] = s e q u e n c e _ o n _ l o s s ;  
             m e m _ l i s t _ p r o f i t [ i d ] = s e q u e n c e _ o n _ p r o f i t ;  
       }  
       m e m _ t i c k e t [ i d ] = O r d e r T i c k e t ( ) ;  
        
       / / -   n o w   t u r n   t h e   s t r i n g   i n t o   i n t e g e r   a r r a y  
       i n t   s = 0 ;  
       d o u b l e   l i s t _ l o s s [ ] ;  
       d o u b l e   l i s t _ p r o f i t [ ] ;  
       s t r i n g   l i s t S [ ] ;  
       S t r i n g E x p l o d e ( " , " ,   m e m _ l i s t _ l o s s [ i d ] ,   l i s t S ) ;  
       A r r a y R e s i z e ( l i s t _ l o s s ,   A r r a y S i z e ( l i s t S ) ,   A r r a y S i z e ( l i s t S ) ) ;  
       f o r   ( s = 0 ;   s < A r r a y S i z e ( l i s t S ) ;   s + + )   {  
             l i s t _ l o s s [ s ] = ( d o u b l e ) S t r i n g T o D o u b l e ( S t r i n g T r i m ( l i s t S [ s ] ) ) ;      
       }  
       S t r i n g E x p l o d e ( " , " ,   m e m _ l i s t _ p r o f i t [ i d ] ,   l i s t S ) ;  
       A r r a y R e s i z e ( l i s t _ p r o f i t ,   A r r a y S i z e ( l i s t S ) ,   A r r a y S i z e ( l i s t S ) ) ;  
       f o r   ( s = 0 ;   s < A r r a y S i z e ( l i s t S ) ;   s + + )   {  
             l i s t _ p r o f i t [ s ] = ( d o u b l e ) S t r i n g T o D o u b l e ( S t r i n g T r i m ( l i s t S [ s ] ) ) ;      
       }  
  
       / / - -  
       i f   ( i n i t i a l _ l o t s   <   M a r k e t I n f o ( s y m b o l , M O D E _ M I N L O T ) )   {  
             i n i t i a l _ l o t s   =   M a r k e t I n f o ( s y m b o l , M O D E _ M I N L O T ) ;      
       }  
  
       i f   ( l o t s = = 0 )   { l o t s   =   i n i t i a l _ l o t s ; }  
       e l s e  
       {  
             i f   ( ( r e v e r s e = = f a l s e   & &   p r o f i t _ o r _ l o s s = = 1 )   | |   ( r e v e r s e = = t r u e   & &   p r o f i t _ o r _ l o s s = = - 1 ) )  
             {  
                   l o t s   =   i n i t i a l _ l o t s * l i s t _ p r o f i t [ 0 ] ;  
                   / /   s h i f t   a r r a y   1   s t e p   l e f t  
                   s i z e = A r r a y S i z e ( l i s t _ p r o f i t ) ;  
                   f o r ( p o s = 0 ;   p o s < s i z e - 1 ;   p o s + + )   {  
                         l i s t _ p r o f i t [ p o s ] = l i s t _ p r o f i t [ p o s + 1 ] ;  
                   }  
                   i f   ( s i z e > 0 )   {  
                         A r r a y R e s i z e ( l i s t _ p r o f i t ,   s i z e - 1 ,   s i z e - 1 ) ;  
                         m e m _ l i s t _ p r o f i t [ i d ] = S t r i n g I m p l o d e ( " , " ,   l i s t _ p r o f i t ) ;  
                   }  
                   / /   r e s e t   t h e   o p p o s i t e   s e q u e n c e  
                   / / m e m _ l i s t _ l o s s [ i d ] = " " ;  
             }  
             e l s e   {  
                    
                   l o t s   =   i n i t i a l _ l o t s * l i s t _ l o s s [ 0 ] ;  
                   / /   s h i f t   a r r a y   1   s t e p   l e f t  
                   s i z e = A r r a y S i z e ( l i s t _ l o s s ) ;  
                   f o r ( p o s = 0 ;   p o s < s i z e - 1 ;   p o s + + )   {  
                         l i s t _ l o s s [ p o s ] = l i s t _ l o s s [ p o s + 1 ] ;  
                   }  
                   i f   ( s i z e > 0 )   {  
                         A r r a y R e s i z e ( l i s t _ l o s s ,   s i z e - 1 ,   s i z e - 1 ) ;  
                         m e m _ l i s t _ l o s s [ i d ] = S t r i n g I m p l o d e ( " , " ,   l i s t _ l o s s ) ;  
                   }  
                   / /   r e s e t   t h e   o p p o s i t e   s e q u e n c e  
                   / / m e m _ l i s t _ p r o f i t [ i d ] = " " ;  
             }  
       }  
        
       r e t u r n   l o t s ;  
 }  
  
 i n t   B u y N o w (  
 	 s t r i n g   s y m b o l ,  
 	 d o u b l e   l o t s ,  
 	 d o u b l e   s l l ,  
 	 d o u b l e   t p l ,  
 	 d o u b l e   s l p ,  
 	 d o u b l e   t p p ,  
 	 d o u b l e   s l i p p a g e   =   0 ,  
 	 i n t   m a g i c   =   0 ,  
 	 s t r i n g   c o m m e n t   =   " " ,  
 	 c o l o r   a r r o w c o l o r   =   c l r N O N E ,  
 	 d a t e t i m e   e x p i r a t i o n   =   0  
 	 )  
 {  
 	 r e t u r n   O r d e r C r e a t e (  
 	 	 s y m b o l ,  
 	 	 O P _ B U Y ,  
 	 	 l o t s ,  
 	 	 0 ,  
 	 	 s l l ,  
 	 	 t p l ,  
 	 	 s l p ,  
 	 	 t p p ,  
 	 	 s l i p p a g e ,  
 	 	 m a g i c ,  
 	 	 c o m m e n t ,  
 	 	 a r r o w c o l o r ,  
 	 	 e x p i r a t i o n  
 	 ) ;  
 }  
  
 i n t   C h e c k F o r T r a d i n g E r r o r ( i n t   e r r o r _ c o d e = - 1 ,   s t r i n g   m s g _ p r e f i x = " " )  
 {  
       / /   r e t u r n   0   - >   n o   e r r o r  
       / /   r e t u r n   1   - >   o v e r c o m a b l e   e r r o r  
       / /   r e t u r n   2   - >   f a t a l   e r r o r  
        
       i f   ( e r r o r _ c o d e < 0 )   {  
             e r r o r _ c o d e = G e t L a s t E r r o r ( ) ;      
       }  
        
       i n t   r e t v a l = 0 ;  
       s t a t i c   i n t   t r y o u t s = 0 ;  
        
       / / - -   e r r o r   c h e c k   - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  
       s w i t c h ( e r r o r _ c o d e )  
       {  
             / / - -   n o   e r r o r  
             c a s e   0 :  
                   r e t v a l = 0 ;  
                   b r e a k ;  
             / / - -   o v e r c o m a b l e   e r r o r s  
             c a s e   1 :   / /   N o   e r r o r   r e t u r n e d  
                   R e f r e s h R a t e s ( ) ;  
                   r e t v a l = 1 ;  
                   b r e a k ;  
             c a s e   4 :   / / E R R _ S E R V E R _ B U S Y  
                   i f   ( m s g _ p r e f i x ! = " " )   { P r i n t ( S t r i n g C o n c a t e n a t e ( m s g _ p r e f i x , " :   " , E r r o r M e s s a g e ( e r r o r _ c o d e ) , " .   R e t r y i n g . . " ) ) ; }  
                   S l e e p ( 1 0 0 0 ) ;  
                   R e f r e s h R a t e s ( ) ;  
                   r e t v a l = 1 ;  
                   b r e a k ;  
             c a s e   6 :   / / E R R _ N O _ C O N N E C T I O N  
                   i f   ( m s g _ p r e f i x ! = " " )   { P r i n t ( S t r i n g C o n c a t e n a t e ( m s g _ p r e f i x , " :   " , E r r o r M e s s a g e ( e r r o r _ c o d e ) , " .   R e t r y i n g . . " ) ) ; }  
                   w h i l e ( ! I s C o n n e c t e d ( ) )   { S l e e p ( 1 0 0 ) ; }  
                   w h i l e ( I s T r a d e C o n t e x t B u s y ( ) )   { S l e e p ( 5 0 ) ; }  
                   R e f r e s h R a t e s ( ) ;  
                   r e t v a l = 1 ;  
                   b r e a k ;  
             c a s e   1 2 8 :   / / E R R _ T R A D E _ T I M E O U T  
                   i f   ( m s g _ p r e f i x ! = " " )   { P r i n t ( S t r i n g C o n c a t e n a t e ( m s g _ p r e f i x , " :   " , E r r o r M e s s a g e ( e r r o r _ c o d e ) , " .   R e t r y i n g . . " ) ) ; }  
                   R e f r e s h R a t e s ( ) ;  
                   r e t v a l = 1 ;  
                   b r e a k ;  
             c a s e   1 2 9 :   / / E R R _ I N V A L I D _ P R I C E  
                   i f   ( m s g _ p r e f i x ! = " " )   { P r i n t ( S t r i n g C o n c a t e n a t e ( m s g _ p r e f i x , " :   " , E r r o r M e s s a g e ( e r r o r _ c o d e ) , " .   R e t r y i n g . . " ) ) ; }  
                   i f   ( ! I s T e s t i n g ( ) )   { w h i l e ( R e f r e s h R a t e s ( ) = = f a l s e )   { S l e e p ( 1 ) ; } }  
                   r e t v a l = 1 ;  
                   b r e a k ;  
             c a s e   1 3 0 :   / / E R R _ I N V A L I D _ S T O P S  
                   i f   ( m s g _ p r e f i x ! = " " )   { P r i n t ( S t r i n g C o n c a t e n a t e ( m s g _ p r e f i x , " :   " , E r r o r M e s s a g e ( e r r o r _ c o d e ) , " .   W a i t i n g   f o r   a   n e w   t i c k   t o   r e t r y . . " ) ) ; }  
                   i f   ( ! I s T e s t i n g ( ) )   { w h i l e ( R e f r e s h R a t e s ( ) = = f a l s e )   { S l e e p ( 1 ) ; } }  
                   r e t v a l = 1 ;  
                   b r e a k ;  
             c a s e   1 3 5 :   / / E R R _ P R I C E _ C H A N G E D  
                   i f   ( m s g _ p r e f i x ! = " " )   { P r i n t ( S t r i n g C o n c a t e n a t e ( m s g _ p r e f i x , " :   " , E r r o r M e s s a g e ( e r r o r _ c o d e ) , " .   W a i t i n g   f o r   a   n e w   t i c k   t o   r e t r y . . " ) ) ; }  
                   i f   ( ! I s T e s t i n g ( ) )   { w h i l e ( R e f r e s h R a t e s ( ) = = f a l s e )   { S l e e p ( 1 ) ; } }  
                   r e t v a l = 1 ;  
                   b r e a k ;  
             c a s e   1 3 6 :   / / E R R _ O F F _ Q U O T E S  
                   i f   ( m s g _ p r e f i x ! = " " )   { P r i n t ( S t r i n g C o n c a t e n a t e ( m s g _ p r e f i x , " :   " , E r r o r M e s s a g e ( e r r o r _ c o d e ) , " .   W a i t i n g   f o r   a   n e w   t i c k   t o   r e t r y . . " ) ) ; }  
                   i f   ( ! I s T e s t i n g ( ) )   { w h i l e ( R e f r e s h R a t e s ( ) = = f a l s e )   { S l e e p ( 1 ) ; } }  
                   r e t v a l = 1 ;  
                   b r e a k ;  
             c a s e   1 3 7 :   / / E R R _ B R O K E R _ B U S Y  
                   i f   ( m s g _ p r e f i x ! = " " )   { P r i n t ( S t r i n g C o n c a t e n a t e ( m s g _ p r e f i x , " :   " , E r r o r M e s s a g e ( e r r o r _ c o d e ) , " .   R e t r y i n g . . " ) ) ; }  
                   S l e e p ( 1 0 0 0 ) ;  
                   r e t v a l = 1 ;  
                   b r e a k ;  
             c a s e   1 3 8 :   / / E R R _ R E Q U O T E  
                   i f   ( m s g _ p r e f i x ! = " " )   { P r i n t ( S t r i n g C o n c a t e n a t e ( m s g _ p r e f i x , " :   " , E r r o r M e s s a g e ( e r r o r _ c o d e ) , " .   W a i t i n g   f o r   a   n e w   t i c k   t o   r e t r y . . " ) ) ; }  
                   i f   ( ! I s T e s t i n g ( ) )   { w h i l e ( R e f r e s h R a t e s ( ) = = f a l s e )   { S l e e p ( 1 ) ; } }  
                   r e t v a l = 1 ;  
                   b r e a k ;  
             c a s e   1 4 2 :   / / T h i s   c o d e   s h o u l d   b e   p r o c e s s e d   i n   t h e   s a m e   w a y   a s   e r r o r   1 2 8 .  
                   i f   ( m s g _ p r e f i x ! = " " )   { P r i n t ( S t r i n g C o n c a t e n a t e ( m s g _ p r e f i x , " :   " , E r r o r M e s s a g e ( e r r o r _ c o d e ) , " .   R e t r y i n g . . " ) ) ; }  
                   R e f r e s h R a t e s ( ) ;  
                   r e t v a l = 1 ;  
                   b r e a k ;  
             c a s e   1 4 3 :   / / T h i s   c o d e   s h o u l d   b e   p r o c e s s e d   i n   t h e   s a m e   w a y   a s   e r r o r   1 2 8 .  
                   i f   ( m s g _ p r e f i x ! = " " )   { P r i n t ( S t r i n g C o n c a t e n a t e ( m s g _ p r e f i x , " :   " , E r r o r M e s s a g e ( e r r o r _ c o d e ) , " .   R e t r y i n g . . " ) ) ; }  
                   R e f r e s h R a t e s ( ) ;  
                   r e t v a l = 1 ;  
                   b r e a k ;  
             / * c a s e   1 4 5 :   / / E R R _ T R A D E _ M O D I F Y _ D E N I E D  
                   i f   ( m s g _ p r e f i x ! = " " )   { P r i n t ( S t r i n g C o n c a t e n a t e ( m s g _ p r e f i x , " :   " , E r r o r M e s s a g e ( e r r o r _ c o d e ) , " .   W a i t i n g   f o r   a   n e w   t i c k   t o   r e t r y . . " ) ) ; }  
                   w h i l e ( R e f r e s h R a t e s ( ) = = f a l s e )   { S l e e p ( 1 ) ; }  
                   r e t u r n ( 1 ) ;  
             * /  
             c a s e   1 4 6 :   / / E R R _ T R A D E _ C O N T E X T _ B U S Y  
                   i f   ( m s g _ p r e f i x ! = " " )   { P r i n t ( S t r i n g C o n c a t e n a t e ( m s g _ p r e f i x , " :   " , E r r o r M e s s a g e ( e r r o r _ c o d e ) , " .   R e t r y i n g . . " ) ) ; }  
                   w h i l e ( I s T r a d e C o n t e x t B u s y ( ) )   { S l e e p ( 5 0 ) ; }  
                   R e f r e s h R a t e s ( ) ;  
                   r e t v a l = 1 ;  
                   b r e a k ;  
             / / - -   c r i t i c a l   e r r o r s  
             d e f a u l t :  
                   i f   ( m s g _ p r e f i x ! = " " )   { P r i n t ( S t r i n g C o n c a t e n a t e ( m s g _ p r e f i x , " :   " , E r r o r M e s s a g e ( e r r o r _ c o d e ) ) ) ; }  
                   r e t v a l = 2 ;  
                   b r e a k ;  
       }  
  
       i f   ( r e t v a l = = 0 )   { t r y o u t s = 0 ; }  
       e l s e   i f   ( r e t v a l = = 1 )   {  
             t r y o u t s + + ;  
             i f   ( t r y o u t s > = 1 0 )   {  
                   t r y o u t s = 0 ;  
                   r e t v a l = 2 ;  
             }   e l s e   {  
                   P r i n t ( " r e t r y   # " + ( s t r i n g ) t r y o u t s + "   o f   1 0 " ) ;  
             }  
       }  
        
       r e t u r n ( r e t v a l ) ;  
 }  
  
 b o o l   C l o s e T r a d e ( u l o n g   t i c k e t ,   u l o n g   s l i p p a g e   =   0 ,   c o l o r   a r r o w c o l o r   =   C L R _ N O N E )  
 {  
 	 b o o l   s u c c e s s   =   f a l s e ;  
  
 	 i f   ( ! O r d e r S e l e c t ( ( i n t ) t i c k e t ,   S E L E C T _ B Y _ T I C K E T ,   M O D E _ T R A D E S ) )  
 	 {  
 	 	 r e t u r n   f a l s e ;  
 	 }  
  
 	 w h i l e   ( t r u e )  
 	 {  
 	 	 / / - -   w a i t   i f   n e e d e d   - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  
 	 	 W a i t T r a d e C o n t e x t I f B u s y ( ) ;  
  
 	 	 / / - -   c l o s e   - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  
 	 	 s u c c e s s   =   O r d e r C l o s e ( ( i n t ) t i c k e t ,   O r d e r L o t s ( ) ,   O r d e r C l o s e P r i c e ( ) ,   ( i n t ) ( s l i p p a g e   *   P i p V a l u e ( O r d e r S y m b o l ( ) ) ) ,   a r r o w c o l o r ) ;  
  
 	 	 i f   ( s u c c e s s   = =   t r u e )  
 	 	 {  
 	 	 	 i f   ( U S E _ V I R T U A L _ S T O P S )   {  
 	 	 	 	 V i r t u a l S t o p s D r i v e r ( " c l e a r " ,   t i c k e t ) ;  
 	 	 	 }  
  
 	 	 	 R e g i s t e r E v e n t ( " t r a d e " ) ;  
  
 	 	 	 r e t u r n   t r u e ;  
 	 	 }  
  
 	 	 / / - -   e r r o r s   - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  
 	 	 i n t   e r r a c t i o n   =   C h e c k F o r T r a d i n g E r r o r ( G e t L a s t E r r o r ( ) ,   " C l o s i n g   t r a d e   # "   +   ( s t r i n g ) t i c k e t   +   "   e r r o r " ) ;  
  
 	 	 s w i t c h ( e r r a c t i o n )  
 	 	 {  
 	 	 	 c a s e   0 :   b r e a k ;         / /   n o   e r r o r  
 	 	 	 c a s e   1 :   c o n t i n u e ;   / /   o v e r c o m a b l e   e r r o r  
 	 	 	 c a s e   2 :   b r e a k ;         / /   f a t a l   e r r o r  
 	 	 }  
  
 	 	 b r e a k ;  
 	 }  
  
 	 r e t u r n   f a l s e ;  
 }  
  
 t e m p l a t e < t y p e n a m e   D T 1 ,   t y p e n a m e   D T 2 >  
 b o o l   C o m p a r e V a l u e s ( s t r i n g   s i g n ,   D T 1   v 1 ,   D T 2   v 2 )  
 {  
 	           i f   ( s i g n   = =   " > " )   r e t u r n ( v 1   >   v 2 ) ;  
 	 e l s e   i f   ( s i g n   = =   " < " )   r e t u r n ( v 1   <   v 2 ) ;  
 	 e l s e   i f   ( s i g n   = =   " > = " )   r e t u r n ( v 1   > =   v 2 ) ;  
 	 e l s e   i f   ( s i g n   = =   " < = " )   r e t u r n ( v 1   < =   v 2 ) ;  
 	 e l s e   i f   ( s i g n   = =   " = = " )   r e t u r n ( v 1   = =   v 2 ) ;  
 	 e l s e   i f   ( s i g n   = =   " ! = " )   r e t u r n ( v 1   ! =   v 2 ) ;  
 	 e l s e   i f   ( s i g n   = =   " x > " )   r e t u r n ( v 1   >   v 2 ) ;  
 	 e l s e   i f   ( s i g n   = =   " x < " )   r e t u r n ( v 1   <   v 2 ) ;  
  
 	 r e t u r n   f a l s e ;  
 }  
  
 s t r i n g   C u r r e n t S y m b o l ( s t r i n g   s y m b o l = " " )  
 {  
       s t a t i c   s t r i n g   m e m o r y = " " ;  
       i f   ( s y m b o l ! = " " )   { m e m o r y = s y m b o l ; }   e l s e  
       i f   ( m e m o r y = = " " )   { m e m o r y = S y m b o l ( ) ; }  
       r e t u r n ( m e m o r y ) ;  
 }  
  
 d o u b l e   C u s t o m P o i n t ( s t r i n g   s y m b o l )  
 {  
 	 s t a t i c   s t r i n g   s y m b o l s [ ] ;  
 	 s t a t i c   d o u b l e   p o i n t s [ ] ;  
 	 s t a t i c   s t r i n g   l a s t _ s y m b o l   =   " - " ;  
 	 s t a t i c   d o u b l e   l a s t _ p o i n t     =   0 ;  
 	 s t a t i c   i n t   l a s t _ i                   =   0 ;  
 	 s t a t i c   i n t   s i z e                       =   0 ;  
  
 	 / / - -   v a r i a n t   A )   u s e   t h e   c a c h e   f o r   t h e   l a s t   u s e d   s y m b o l  
 	 i f   ( s y m b o l   = =   l a s t _ s y m b o l )  
 	 {  
 	 	 r e t u r n   l a s t _ p o i n t ;  
 	 }  
  
 	 / / - -   v a r i a n t   B )   s e a r c h   i n   t h e   a r r a y   c a c h e  
 	 i n t   i 	 	 	 =   l a s t _ i ;  
 	 i n t   s t a r t _ i 	 =   i ;  
 	 b o o l   f o u n d 	 =   f a l s e ;  
  
 	 i f   ( s i z e   >   0 )  
 	 {  
 	 	 w h i l e   ( t r u e )  
 	 	 {  
 	 	 	 i f   ( s y m b o l s [ i ]   = =   s y m b o l )  
 	 	 	 {  
 	 	 	 	 l a s t _ s y m b o l 	 =   s y m b o l ;  
 	 	 	 	 l a s t _ p o i n t 	 =   p o i n t s [ i ] ;  
 	 	 	 	 l a s t _ i 	 	 =   i ;  
  
 	 	 	 	 r e t u r n   l a s t _ p o i n t ;  
 	 	 	 }  
  
 	 	 	 i + + ;  
  
 	 	 	 i f   ( i   > =   s i z e )  
 	 	 	 {  
 	 	 	 	 i   =   0 ;  
 	 	 	 }  
 	 	 	 i f   ( i   = =   s t a r t _ i )   { b r e a k ; }  
 	 	 }  
 	 }  
  
 	 / / - -   v a r i a n t   C )   a d d   t h i s   s y m b o l   t o   t h e   c a c h e  
 	 i 	 	 =   s i z e ;  
 	 s i z e 	 =   s i z e   +   1 ;  
  
 	 A r r a y R e s i z e ( s y m b o l s ,   s i z e ) ;  
 	 A r r a y R e s i z e ( p o i n t s ,   s i z e ) ;  
  
 	 s y m b o l s [ i ] 	 =   s y m b o l ;  
 	 p o i n t s [ i ] 	 =   0 ;  
 	 l a s t _ s y m b o l 	 =   s y m b o l ;  
 	 l a s t _ i 	 	 =   i ;  
  
 	 / / - -   u n s e r i a l i z e   r u l e s   f r o m   F X D _ P O I N T _ F O R M A T _ R U L E S  
 	 s t r i n g   r u l e s [ ] ;  
 	 S t r i n g E x p l o d e ( " , " ,   P O I N T _ F O R M A T _ R U L E S ,   r u l e s ) ;  
  
 	 i n t   r u l e s _ c o u n t   =   A r r a y S i z e ( r u l e s ) ;  
  
 	 i f   ( r u l e s _ c o u n t   >   0 )  
 	 {  
 	 	 s t r i n g   r u l e [ ] ;  
  
 	 	 f o r   ( i n t   r   =   0 ;   r   <   r u l e s _ c o u n t ;   r + + )  
 	 	 {  
 	 	 	 S t r i n g E x p l o d e ( " = " ,   r u l e s [ r ] ,   r u l e ) ;  
  
 	 	 	 / / - -   a   s i n g l e   r u l e   m u s t   c o n t a i n   2   p a r t s ,   [ 0 ]   f r o m   a n d   [ 1 ]   t o  
 	 	 	 i f   ( A r r a y S i z e ( r u l e )   ! =   2 )   { c o n t i n u e ; }  
  
 	 	 	 d o u b l e   f r o m   =   S t r i n g T o D o u b l e ( r u l e [ 0 ] ) ;  
 	 	 	 d o u b l e   t o 	 =   S t r i n g T o D o u b l e ( r u l e [ 1 ] ) ;  
  
 	 	 	 / / - -   " t o "   m u s t   b e   a   p o s i t i v e   n u m b e r ,   d i f f e r e n t   t h a n   0  
 	 	 	 i f   ( t o   < =   0 )   { c o n t i n u e ; }  
  
 	 	 	 / / - -   " f r o m "   c a n   b e   a   n u m b e r   o r   a   s t r i n g  
 	 	 	 / /   a )   s t r i n g  
 	 	 	 i f   ( f r o m   = =   0   & &   S t r i n g L e n ( r u l e [ 0 ] )   >   0 )  
 	 	 	 {  
 	 	 	 	 s t r i n g   s _ f r o m   =   r u l e [ 0 ] ;  
 	 	 	 	 i n t   p o s               =   S t r i n g F i n d ( s _ f r o m ,   " ? " ) ;  
  
 	 	 	 	 i f   ( p o s   <   0 )   / /   ?   n o t   f o u n d  
 	 	 	 	 {  
 	 	 	 	 	 i f   ( S t r i n g F i n d ( s y m b o l ,   s _ f r o m )   = =   0 )   { p o i n t s [ i ]   =   t o ; }  
 	 	 	 	 }  
 	 	 	 	 e l s e   i f   ( p o s   = =   0 )   / /   ?   i s   t h e   f i r s t   s y m b o l   = >   m a t c h   t h e   s e c o n d   s y m b o l  
 	 	 	 	 {  
 	 	 	 	 	 i f   ( S t r i n g F i n d ( s y m b o l ,   S t r i n g S u b s t r ( s _ f r o m ,   1 ) ,   3 )   = =   3 )  
 	 	 	 	 	 {  
 	 	 	 	 	 	 p o i n t s [ i ]   =   t o ;  
 	 	 	 	 	 }  
 	 	 	 	 }  
 	 	 	 	 e l s e   i f   ( p o s   >   0 )   / /   ?   i s   t h e   s e c o n d   s y m b o l   = >   m a t c h   t h e   f i r s t   s y m b o l  
 	 	 	 	 {  
 	 	 	 	 	 i f   ( S t r i n g F i n d ( s y m b o l ,   S t r i n g S u b s t r ( s _ f r o m ,   0 ,   p o s ) )   = =   0 )  
 	 	 	 	 	 {  
 	 	 	 	 	 	 p o i n t s [ i ]   =   t o ;  
 	 	 	 	 	 }  
 	 	 	 	 }  
 	 	 	 }  
  
 	 	 	 / /   b )   n u m b e r  
 	 	 	 i f   ( f r o m   = =   0 )   { c o n t i n u e ; }  
  
 	 	 	 i f   ( S y m b o l I n f o D o u b l e ( s y m b o l ,   S Y M B O L _ P O I N T )   = =   f r o m )  
 	 	 	 {  
 	 	 	 	 p o i n t s [ i ]   =   t o ;  
 	 	 	 }  
 	 	 }  
 	 }  
  
 	 i f   ( p o i n t s [ i ]   = =   0 )  
 	 {  
 	 	 p o i n t s [ i ]   =   S y m b o l I n f o D o u b l e ( s y m b o l ,   S Y M B O L _ P O I N T ) ;  
 	 }  
  
 	 l a s t _ p o i n t   =   p o i n t s [ i ] ;  
  
 	 r e t u r n   l a s t _ p o i n t ;  
 }  
  
 b o o l   D e l e t e O r d e r ( i n t   t i c k e t ,   c o l o r   a r r o w c o l o r = c l r N O N E )  
 {  
       b o o l   s u c c e s s = f a l s e ;  
       i f   ( ! O r d e r S e l e c t ( t i c k e t , S E L E C T _ B Y _ T I C K E T , M O D E _ T R A D E S ) )   { r e t u r n ( f a l s e ) ; }  
        
       w h i l e ( t r u e )  
       {  
             / / - -   w a i t   i f   n e e d e d   - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  
             W a i t T r a d e C o n t e x t I f B u s y ( ) ;  
             / / - -   d e l e t e   - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  
             s u c c e s s = O r d e r D e l e t e ( t i c k e t , a r r o w c o l o r ) ;  
             i f   ( s u c c e s s = = t r u e )   {  
                   i f   ( U S E _ V I R T U A L _ S T O P S )   {  
                         V i r t u a l S t o p s D r i v e r ( " c l e a r " , t i c k e t ) ;  
                   }  
                   R e g i s t e r E v e n t ( " t r a d e " ) ;  
                   r e t u r n ( t r u e ) ;  
             }  
             / / - -   e r r o r   c h e c k   - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  
             i n t   e r r a c t i o n = C h e c k F o r T r a d i n g E r r o r ( G e t L a s t E r r o r ( ) ,   " D e l e t i n g   o r d e r   # " + ( s t r i n g ) t i c k e t + "   e r r o r " ) ;  
             s w i t c h ( e r r a c t i o n )  
             {  
                   c a s e   0 :   b r e a k ;         / /   n o   e r r o r  
                   c a s e   1 :   c o n t i n u e ;   / /   o v e r c o m a b l e   e r r o r  
                   c a s e   2 :   b r e a k ;         / /   f a t a l   e r r o r  
             }  
             b r e a k ;  
       }  
       r e t u r n ( f a l s e ) ;  
 }  
  
 v o i d   D r a w S p r e a d I n f o ( )  
 {  
       s t a t i c   b o o l   a l l o w _ d r a w   =   t r u e ;  
       i f   ( a l l o w _ d r a w = = f a l s e )   { r e t u r n ; }  
       i f   ( M Q L I n f o I n t e g e r ( M Q L _ T E S T E R )   & &   ! M Q L I n f o I n t e g e r ( M Q L _ V I S U A L _ M O D E ) )   { a l l o w _ d r a w = f a l s e ; }   / /   A l l o w e d   t o   d r a w   o n l y   o n c e   i n   t e s t i n g   m o d e  
  
       s t a t i c   b o o l   p a s s e d                   =   f a l s e ;  
       s t a t i c   d o u b l e   m a x _ s p r e a d       =   0 ;  
       s t a t i c   d o u b l e   m i n _ s p r e a d       =   E M P T Y _ V A L U E ;  
       s t a t i c   d o u b l e   a v g _ s p r e a d       =   0 ;  
       s t a t i c   d o u b l e   a v g _ a d d             =   0 ;  
       s t a t i c   d o u b l e   a v g _ c n t             =   0 ;  
  
       d o u b l e   c u s t o m _ p o i n t   =   C u s t o m P o i n t ( S y m b o l ( ) ) ;  
       d o u b l e   c u r r e n t _ s p r e a d   =   0 ;  
       i f   ( c u s t o m _ p o i n t   >   0 )   {  
             c u r r e n t _ s p r e a d   =   ( S y m b o l I n f o D o u b l e ( S y m b o l ( ) , S Y M B O L _ A S K ) - S y m b o l I n f o D o u b l e ( S y m b o l ( ) , S Y M B O L _ B I D ) ) / c u s t o m _ p o i n t ;  
       }  
       i f   ( c u r r e n t _ s p r e a d   >   m a x _ s p r e a d )   { m a x _ s p r e a d   =   c u r r e n t _ s p r e a d ; }  
       i f   ( c u r r e n t _ s p r e a d   <   m i n _ s p r e a d )   { m i n _ s p r e a d   =   c u r r e n t _ s p r e a d ; }  
        
       a v g _ c n t + + ;  
       a v g _ a d d           =   a v g _ a d d   +   c u r r e n t _ s p r e a d ;  
       a v g _ s p r e a d     =   a v g _ a d d   /   a v g _ c n t ;  
  
       i n t   x = 0 ;   i n t   y = 0 ;  
       s t r i n g   n a m e ;  
  
       / /   c r e a t e   o b j e c t s  
       i f   ( p a s s e d   = =   f a l s e )  
       {  
             p a s s e d = t r u e ;  
              
             n a m e = " f x d _ s p r e a d _ c u r r e n t _ l a b e l " ;  
             i f   ( O b j e c t F i n d ( 0 ,   n a m e ) = = - 1 )   {  
                   O b j e c t C r e a t e ( 0 ,   n a m e ,   O B J _ L A B E L ,   0 ,   0 ,   0 ) ;  
                   O b j e c t S e t I n t e g e r ( 0 ,   n a m e ,   O B J P R O P _ X D I S T A N C E ,   x + 1 ) ;  
                   O b j e c t S e t I n t e g e r ( 0 ,   n a m e ,   O B J P R O P _ Y D I S T A N C E ,   y + 1 ) ;  
                   O b j e c t S e t I n t e g e r ( 0 ,   n a m e ,   O B J P R O P _ C O R N E R ,   C O R N E R _ L E F T _ L O W E R ) ;  
                   O b j e c t S e t I n t e g e r ( 0 ,   n a m e ,   O B J P R O P _ A N C H O R ,   A N C H O R _ L E F T _ L O W E R ) ;  
                   O b j e c t S e t I n t e g e r ( 0 ,   n a m e ,   O B J P R O P _ H I D D E N ,   t r u e ) ;  
                   O b j e c t S e t I n t e g e r ( 0 ,   n a m e ,   O B J P R O P _ F O N T S I Z E ,   1 8 ) ;  
                   O b j e c t S e t I n t e g e r ( 0 ,   n a m e ,   O B J P R O P _ C O L O R ,   c l r D a r k O r a n g e ) ;  
                   O b j e c t S e t S t r i n g ( 0 ,   n a m e ,   O B J P R O P _ F O N T ,   " A r i a l " ) ;  
                   O b j e c t S e t S t r i n g ( 0 ,   n a m e ,   O B J P R O P _ T E X T ,   " S p r e a d : " ) ;  
             }  
             n a m e = " f x d _ s p r e a d _ m a x _ l a b e l " ;  
             i f   ( O b j e c t F i n d ( 0 ,   n a m e ) = = - 1 )   {  
                   O b j e c t C r e a t e ( 0 ,   n a m e ,   O B J _ L A B E L ,   0 ,   0 ,   0 ) ;  
                   O b j e c t S e t I n t e g e r ( 0 ,   n a m e ,   O B J P R O P _ X D I S T A N C E ,   x + 1 4 8 ) ;  
                   O b j e c t S e t I n t e g e r ( 0 ,   n a m e ,   O B J P R O P _ Y D I S T A N C E ,   y + 1 7 ) ;  
                   O b j e c t S e t I n t e g e r ( 0 ,   n a m e ,   O B J P R O P _ C O R N E R ,   C O R N E R _ L E F T _ L O W E R ) ;  
                   O b j e c t S e t I n t e g e r ( 0 ,   n a m e ,   O B J P R O P _ A N C H O R ,   A N C H O R _ L E F T _ L O W E R ) ;  
                   O b j e c t S e t I n t e g e r ( 0 ,   n a m e ,   O B J P R O P _ H I D D E N ,   t r u e ) ;  
                   O b j e c t S e t I n t e g e r ( 0 ,   n a m e ,   O B J P R O P _ F O N T S I Z E ,   7 ) ;  
                   O b j e c t S e t I n t e g e r ( 0 ,   n a m e ,   O B J P R O P _ C O L O R ,   c l r O r a n g e R e d ) ;  
                   O b j e c t S e t S t r i n g ( 0 ,   n a m e ,   O B J P R O P _ F O N T ,   " A r i a l " ) ;  
                   O b j e c t S e t S t r i n g ( 0 ,   n a m e ,   O B J P R O P _ T E X T ,   " m a x : " ) ;  
             }  
             n a m e = " f x d _ s p r e a d _ a v g _ l a b e l " ;  
             i f   ( O b j e c t F i n d ( 0 ,   n a m e ) = = - 1 )   {  
                   O b j e c t C r e a t e ( 0 ,   n a m e ,   O B J _ L A B E L ,   0 ,   0 ,   0 ) ;  
                   O b j e c t S e t I n t e g e r ( 0 ,   n a m e ,   O B J P R O P _ X D I S T A N C E ,   x + 1 4 8 ) ;  
                   O b j e c t S e t I n t e g e r ( 0 ,   n a m e ,   O B J P R O P _ Y D I S T A N C E ,   y + 9 ) ;  
                   O b j e c t S e t I n t e g e r ( 0 ,   n a m e ,   O B J P R O P _ C O R N E R ,   C O R N E R _ L E F T _ L O W E R ) ;  
                   O b j e c t S e t I n t e g e r ( 0 ,   n a m e ,   O B J P R O P _ A N C H O R ,   A N C H O R _ L E F T _ L O W E R ) ;  
                   O b j e c t S e t I n t e g e r ( 0 ,   n a m e ,   O B J P R O P _ H I D D E N ,   t r u e ) ;  
                   O b j e c t S e t I n t e g e r ( 0 ,   n a m e ,   O B J P R O P _ F O N T S I Z E ,   7 ) ;  
                   O b j e c t S e t I n t e g e r ( 0 ,   n a m e ,   O B J P R O P _ C O L O R ,   c l r D a r k O r a n g e ) ;  
                   O b j e c t S e t S t r i n g ( 0 ,   n a m e ,   O B J P R O P _ F O N T ,   " A r i a l " ) ;  
                   O b j e c t S e t S t r i n g ( 0 ,   n a m e ,   O B J P R O P _ T E X T ,   " a v g : " ) ;  
             }  
             n a m e = " f x d _ s p r e a d _ m i n _ l a b e l " ;  
             i f   ( O b j e c t F i n d ( 0 ,   n a m e ) = = - 1 )   {  
                   O b j e c t C r e a t e ( 0 ,   n a m e ,   O B J _ L A B E L ,   0 ,   0 ,   0 ) ;  
                   O b j e c t S e t I n t e g e r ( 0 ,   n a m e ,   O B J P R O P _ X D I S T A N C E ,   x + 1 4 8 ) ;  
                   O b j e c t S e t I n t e g e r ( 0 ,   n a m e ,   O B J P R O P _ Y D I S T A N C E ,   y + 1 ) ;  
                   O b j e c t S e t I n t e g e r ( 0 ,   n a m e ,   O B J P R O P _ C O R N E R ,   C O R N E R _ L E F T _ L O W E R ) ;  
                   O b j e c t S e t I n t e g e r ( 0 ,   n a m e ,   O B J P R O P _ A N C H O R ,   A N C H O R _ L E F T _ L O W E R ) ;  
                   O b j e c t S e t I n t e g e r ( 0 ,   n a m e ,   O B J P R O P _ H I D D E N ,   t r u e ) ;  
                   O b j e c t S e t I n t e g e r ( 0 ,   n a m e ,   O B J P R O P _ F O N T S I Z E ,   7 ) ;  
                   O b j e c t S e t I n t e g e r ( 0 ,   n a m e ,   O B J P R O P _ C O L O R ,   c l r G o l d ) ;  
                   O b j e c t S e t S t r i n g ( 0 ,   n a m e ,   O B J P R O P _ F O N T ,   " A r i a l " ) ;  
                   O b j e c t S e t S t r i n g ( 0 ,   n a m e ,   O B J P R O P _ T E X T ,   " m i n : " ) ;  
             }  
             n a m e = " f x d _ s p r e a d _ c u r r e n t " ;  
             i f   ( O b j e c t F i n d ( 0 ,   n a m e ) = = - 1 )   {  
                   O b j e c t C r e a t e ( 0 ,   n a m e ,   O B J _ L A B E L ,   0 ,   0 ,   0 ) ;  
                   O b j e c t S e t I n t e g e r ( 0 ,   n a m e ,   O B J P R O P _ X D I S T A N C E ,   x + 9 3 ) ;  
                   O b j e c t S e t I n t e g e r ( 0 ,   n a m e ,   O B J P R O P _ Y D I S T A N C E ,   y + 1 ) ;  
                   O b j e c t S e t I n t e g e r ( 0 ,   n a m e ,   O B J P R O P _ C O R N E R ,   C O R N E R _ L E F T _ L O W E R ) ;  
                   O b j e c t S e t I n t e g e r ( 0 ,   n a m e ,   O B J P R O P _ A N C H O R ,   A N C H O R _ L E F T _ L O W E R ) ;  
                   O b j e c t S e t I n t e g e r ( 0 ,   n a m e ,   O B J P R O P _ H I D D E N ,   t r u e ) ;  
                   O b j e c t S e t I n t e g e r ( 0 ,   n a m e ,   O B J P R O P _ F O N T S I Z E ,   1 8 ) ;  
                   O b j e c t S e t I n t e g e r ( 0 ,   n a m e ,   O B J P R O P _ C O L O R ,   c l r D a r k O r a n g e ) ;  
                   O b j e c t S e t S t r i n g ( 0 ,   n a m e ,   O B J P R O P _ F O N T ,   " A r i a l " ) ;  
                   O b j e c t S e t S t r i n g ( 0 ,   n a m e ,   O B J P R O P _ T E X T ,   " 0 " ) ;  
             }  
             n a m e = " f x d _ s p r e a d _ m a x " ;  
             i f   ( O b j e c t F i n d ( 0 ,   n a m e ) = = - 1 )   {  
                   O b j e c t C r e a t e ( 0 ,   n a m e ,   O B J _ L A B E L ,   0 ,   0 ,   0 ) ;  
                   O b j e c t S e t I n t e g e r ( 0 ,   n a m e ,   O B J P R O P _ X D I S T A N C E ,   x + 1 7 3 ) ;  
                   O b j e c t S e t I n t e g e r ( 0 ,   n a m e ,   O B J P R O P _ Y D I S T A N C E ,   y + 1 7 ) ;  
                   O b j e c t S e t I n t e g e r ( 0 ,   n a m e ,   O B J P R O P _ C O R N E R ,   C O R N E R _ L E F T _ L O W E R ) ;  
                   O b j e c t S e t I n t e g e r ( 0 ,   n a m e ,   O B J P R O P _ A N C H O R ,   A N C H O R _ L E F T _ L O W E R ) ;  
                   O b j e c t S e t I n t e g e r ( 0 ,   n a m e ,   O B J P R O P _ H I D D E N ,   t r u e ) ;  
                   O b j e c t S e t I n t e g e r ( 0 ,   n a m e ,   O B J P R O P _ F O N T S I Z E ,   7 ) ;  
                   O b j e c t S e t I n t e g e r ( 0 ,   n a m e ,   O B J P R O P _ C O L O R ,   c l r O r a n g e R e d ) ;  
                   O b j e c t S e t S t r i n g ( 0 ,   n a m e ,   O B J P R O P _ F O N T ,   " A r i a l " ) ;  
                   O b j e c t S e t S t r i n g ( 0 ,   n a m e ,   O B J P R O P _ T E X T ,   " 0 " ) ;  
             }  
             n a m e = " f x d _ s p r e a d _ a v g " ;  
             i f   ( O b j e c t F i n d ( 0 ,   n a m e ) = = - 1 )   {  
                   O b j e c t C r e a t e ( 0 ,   n a m e ,   O B J _ L A B E L ,   0 ,   0 ,   0 ) ;  
                   O b j e c t S e t I n t e g e r ( 0 ,   n a m e ,   O B J P R O P _ X D I S T A N C E ,   x + 1 7 3 ) ;  
                   O b j e c t S e t I n t e g e r ( 0 ,   n a m e ,   O B J P R O P _ Y D I S T A N C E ,   y + 9 ) ;  
                   O b j e c t S e t I n t e g e r ( 0 ,   n a m e ,   O B J P R O P _ C O R N E R ,   C O R N E R _ L E F T _ L O W E R ) ;  
                   O b j e c t S e t I n t e g e r ( 0 ,   n a m e ,   O B J P R O P _ A N C H O R ,   A N C H O R _ L E F T _ L O W E R ) ;  
                   O b j e c t S e t I n t e g e r ( 0 ,   n a m e ,   O B J P R O P _ H I D D E N ,   t r u e ) ;  
                   O b j e c t S e t I n t e g e r ( 0 ,   n a m e ,   O B J P R O P _ F O N T S I Z E ,   7 ) ;  
                   O b j e c t S e t I n t e g e r ( 0 ,   n a m e ,   O B J P R O P _ C O L O R ,   c l r D a r k O r a n g e ) ;  
                   O b j e c t S e t S t r i n g ( 0 ,   n a m e ,   O B J P R O P _ F O N T ,   " A r i a l " ) ;  
                   O b j e c t S e t S t r i n g ( 0 ,   n a m e ,   O B J P R O P _ T E X T ,   " 0 " ) ;  
             }  
             n a m e = " f x d _ s p r e a d _ m i n " ;  
             i f   ( O b j e c t F i n d ( 0 ,   n a m e ) = = - 1 )   {  
                   O b j e c t C r e a t e ( 0 ,   n a m e ,   O B J _ L A B E L ,   0 ,   0 ,   0 ) ;  
                   O b j e c t S e t I n t e g e r ( 0 ,   n a m e ,   O B J P R O P _ X D I S T A N C E ,   x + 1 7 3 ) ;  
                   O b j e c t S e t I n t e g e r ( 0 ,   n a m e ,   O B J P R O P _ Y D I S T A N C E ,   y + 1 ) ;  
                   O b j e c t S e t I n t e g e r ( 0 ,   n a m e ,   O B J P R O P _ C O R N E R ,   C O R N E R _ L E F T _ L O W E R ) ;  
                   O b j e c t S e t I n t e g e r ( 0 ,   n a m e ,   O B J P R O P _ A N C H O R ,   A N C H O R _ L E F T _ L O W E R ) ;  
                   O b j e c t S e t I n t e g e r ( 0 ,   n a m e ,   O B J P R O P _ H I D D E N ,   t r u e ) ;  
                   O b j e c t S e t I n t e g e r ( 0 ,   n a m e ,   O B J P R O P _ F O N T S I Z E ,   7 ) ;  
                   O b j e c t S e t I n t e g e r ( 0 ,   n a m e ,   O B J P R O P _ C O L O R ,   c l r G o l d ) ;  
                   O b j e c t S e t S t r i n g ( 0 ,   n a m e ,   O B J P R O P _ F O N T ,   " A r i a l " ) ;  
                   O b j e c t S e t S t r i n g ( 0 ,   n a m e ,   O B J P R O P _ T E X T ,   " 0 " ) ;  
             }  
       }  
        
       O b j e c t S e t S t r i n g ( 0 ,   " f x d _ s p r e a d _ c u r r e n t " ,   O B J P R O P _ T E X T ,   D o u b l e T o S t r ( c u r r e n t _ s p r e a d , 2 ) ) ;  
       O b j e c t S e t S t r i n g ( 0 ,   " f x d _ s p r e a d _ m a x " ,   O B J P R O P _ T E X T ,   D o u b l e T o S t r ( m a x _ s p r e a d , 2 ) ) ;  
       O b j e c t S e t S t r i n g ( 0 ,   " f x d _ s p r e a d _ a v g " ,   O B J P R O P _ T E X T ,   D o u b l e T o S t r ( a v g _ s p r e a d , 2 ) ) ;  
       O b j e c t S e t S t r i n g ( 0 ,   " f x d _ s p r e a d _ m i n " ,   O B J P R O P _ T E X T ,   D o u b l e T o S t r ( m i n _ s p r e a d , 2 ) ) ;  
 }  
  
 s t r i n g   D r a w S t a t u s ( s t r i n g   t e x t = " " )  
 {  
       s t a t i c   s t r i n g   m e m o r y ;  
       i f   ( t e x t = = " " )   {  
             r e t u r n ( m e m o r y ) ;  
       }  
        
       s t a t i c   b o o l   p a s s e d   =   f a l s e ;  
       i n t   x = 2 1 0 ;   i n t   y = 0 ;  
       s t r i n g   n a m e ;  
  
       / / - -   d r a w   t h e   o b j e c t s   o n c e  
       i f   ( p a s s e d   = =   f a l s e )  
       {  
             p a s s e d   =   t r u e ;  
             n a m e = " f x d _ s t a t u s _ t i t l e " ;  
             O b j e c t C r e a t e ( 0 , n a m e ,   O B J _ L A B E L ,   0 ,   0 ,   0 ) ;  
             O b j e c t S e t I n t e g e r ( 0 , n a m e ,   O B J P R O P _ B A C K ,   f a l s e ) ;  
             O b j e c t S e t I n t e g e r ( 0 ,   n a m e ,   O B J P R O P _ C O R N E R ,   C O R N E R _ L E F T _ L O W E R ) ;  
             O b j e c t S e t I n t e g e r ( 0 ,   n a m e ,   O B J P R O P _ A N C H O R ,   A N C H O R _ L E F T _ L O W E R ) ;  
             O b j e c t S e t I n t e g e r ( 0 ,   n a m e ,   O B J P R O P _ H I D D E N ,   t r u e ) ;  
             O b j e c t S e t I n t e g e r ( 0 , n a m e ,   O B J P R O P _ X D I S T A N C E ,   x ) ;  
             O b j e c t S e t I n t e g e r ( 0 , n a m e ,   O B J P R O P _ Y D I S T A N C E ,   y + 1 7 ) ;  
             O b j e c t S e t S t r i n g ( 0 , n a m e ,   O B J P R O P _ T E X T ,   " S t a t u s " ) ;  
             O b j e c t S e t S t r i n g ( 0 , n a m e ,   O B J P R O P _ F O N T ,   " A r i a l " ) ;  
             O b j e c t S e t I n t e g e r ( 0 , n a m e ,   O B J P R O P _ F O N T S I Z E ,   7 ) ;  
             O b j e c t S e t I n t e g e r ( 0 , n a m e ,   O B J P R O P _ C O L O R ,   c l r G r a y ) ;  
              
             n a m e = " f x d _ s t a t u s _ t e x t " ;  
             O b j e c t C r e a t e ( 0 , n a m e ,   O B J _ L A B E L ,   0 ,   0 ,   0 ) ;  
             O b j e c t S e t I n t e g e r ( 0 , n a m e ,   O B J P R O P _ B A C K ,   f a l s e ) ;  
             O b j e c t S e t I n t e g e r ( 0 ,   n a m e ,   O B J P R O P _ C O R N E R ,   C O R N E R _ L E F T _ L O W E R ) ;  
             O b j e c t S e t I n t e g e r ( 0 ,   n a m e ,   O B J P R O P _ A N C H O R ,   A N C H O R _ L E F T _ L O W E R ) ;  
             O b j e c t S e t I n t e g e r ( 0 ,   n a m e ,   O B J P R O P _ H I D D E N ,   t r u e ) ;  
             O b j e c t S e t I n t e g e r ( 0 , n a m e ,   O B J P R O P _ X D I S T A N C E ,   x + 2 ) ;  
             O b j e c t S e t I n t e g e r ( 0 , n a m e ,   O B J P R O P _ Y D I S T A N C E ,   y + 1 ) ;  
             O b j e c t S e t S t r i n g ( 0 , n a m e ,   O B J P R O P _ F O N T ,   " A r i a l " ) ;  
             O b j e c t S e t I n t e g e r ( 0 , n a m e ,   O B J P R O P _ F O N T S I Z E ,   1 2 ) ;  
             O b j e c t S e t I n t e g e r ( 0 , n a m e ,   O B J P R O P _ C O L O R ,   c l r A q u a ) ;  
       }  
  
       / / - -   u p d a t e   t h e   t e x t   w h e n   n e e d e d  
       i f   ( t e x t   ! =   m e m o r y )   {  
             m e m o r y = t e x t ;  
             O b j e c t S e t S t r i n g ( 0 , " f x d _ s t a t u s _ t e x t " ,   O B J P R O P _ T E X T ,   t e x t ) ;  
       }  
        
       r e t u r n ( t e x t ) ;  
 }  
  
 d o u b l e   D y n a m i c L o t s ( s t r i n g   s y m b o l ,   s t r i n g   m o d e = " b a l a n c e " ,   d o u b l e   v a l u e = 0 ,   d o u b l e   s l = 0 ,   s t r i n g   a l i g n = " a l i g n " ,   d o u b l e   R J F R _ i n i t i a l _ l o t s = 0 )  
 {  
       d o u b l e   s i z e = 0 ;  
       d o u b l e   L o t S t e p = M a r k e t I n f o ( s y m b o l , M O D E _ L O T S T E P ) ;  
       d o u b l e   L o t S i z e = M a r k e t I n f o ( s y m b o l , M O D E _ L O T S I Z E ) ;  
       d o u b l e   M i n L o t s = M a r k e t I n f o ( s y m b o l , M O D E _ M I N L O T ) ;  
       d o u b l e   M a x L o t s = M a r k e t I n f o ( s y m b o l , M O D E _ M A X L O T ) ;  
       d o u b l e   T i c k V a l u e = M a r k e t I n f o ( s y m b o l , M O D E _ T I C K V A L U E ) ;  
       d o u b l e   p o i n t = M a r k e t I n f o ( s y m b o l , M O D E _ P O I N T ) ;  
       d o u b l e   t i c k s i z e = M a r k e t I n f o ( s y m b o l , M O D E _ T I C K S I Z E ) ;  
       d o u b l e   m a r g i n _ r e q u i r e d = M a r k e t I n f o ( s y m b o l , M O D E _ M A R G I N R E Q U I R E D ) ;  
        
       i f   ( m o d e = = " f i x e d "   | |   m o d e = = " l o t s " )           { s i z e = v a l u e ; }  
       e l s e   i f   ( m o d e = = " b l o c k - e q u i t y " )             { s i z e = ( v a l u e / 1 0 0 ) * A c c o u n t E q u i t y ( ) / m a r g i n _ r e q u i r e d ; }  
       e l s e   i f   ( m o d e = = " b l o c k - b a l a n c e " )           { s i z e = ( v a l u e / 1 0 0 ) * A c c o u n t B a l a n c e ( ) / m a r g i n _ r e q u i r e d ; }  
       e l s e   i f   ( m o d e = = " b l o c k - f r e e m a r g i n " )     { s i z e = ( v a l u e / 1 0 0 ) * A c c o u n t F r e e M a r g i n ( ) / m a r g i n _ r e q u i r e d ; }  
       e l s e   i f   ( m o d e = = " e q u i t y " )             { s i z e = ( v a l u e / 1 0 0 ) * A c c o u n t E q u i t y ( ) / ( L o t S i z e * T i c k V a l u e ) ; }  
       e l s e   i f   ( m o d e = = " b a l a n c e " )           { s i z e = ( v a l u e / 1 0 0 ) * A c c o u n t B a l a n c e ( ) / ( L o t S i z e * T i c k V a l u e ) ; }  
       e l s e   i f   ( m o d e = = " f r e e m a r g i n " )     { s i z e = ( v a l u e / 1 0 0 ) * A c c o u n t F r e e M a r g i n ( ) / ( L o t S i z e * T i c k V a l u e ) ; }  
       e l s e   i f   ( m o d e = = " e q u i t y R i s k " )           { s i z e = ( ( v a l u e / 1 0 0 ) * A c c o u n t E q u i t y ( ) ) / ( s l * ( ( T i c k V a l u e / t i c k s i z e ) * p o i n t ) * P i p V a l u e ( s y m b o l ) ) ; }  
       e l s e   i f   ( m o d e = = " b a l a n c e R i s k " )         { s i z e = ( ( v a l u e / 1 0 0 ) * A c c o u n t B a l a n c e ( ) ) / ( s l * ( ( T i c k V a l u e / t i c k s i z e ) * p o i n t ) * P i p V a l u e ( s y m b o l ) ) ; }  
       e l s e   i f   ( m o d e = = " f r e e m a r g i n R i s k " )   { s i z e = ( ( v a l u e / 1 0 0 ) * A c c o u n t F r e e M a r g i n ( ) ) / ( s l * ( ( T i c k V a l u e / t i c k s i z e ) * p o i n t ) * P i p V a l u e ( s y m b o l ) ) ; }  
       e l s e   i f   ( m o d e = = " f i x e d R i s k " )       { s i z e = ( v a l u e ) / ( s l * ( ( T i c k V a l u e / t i c k s i z e ) * p o i n t ) * P i p V a l u e ( s y m b o l ) ) ; }  
       e l s e   i f   ( m o d e = = " f i x e d R a t i o "   | |   m o d e = = " R J F R " )   {  
              
             / / / / /  
             / /   R y a n   J o n e s   F i x e d   R a t i o   M M   s t a t i c   d a t a  
             s t a t i c   d o u b l e   R J F R _ s t a r t _ l o t s = 0 ;  
             s t a t i c   d o u b l e   R J F R _ d e l t a = 0 ;  
             s t a t i c   d o u b l e   R J F R _ u n i t s = 1 ;  
             s t a t i c   d o u b l e   R J F R _ t a r g e t _ l o w e r = 0 ;  
             s t a t i c   d o u b l e   R J F R _ t a r g e t _ u p p e r = 0 ;  
             / / / / /  
              
             i f   ( R J F R _ s t a r t _ l o t s < = 0 )   { R J F R _ s t a r t _ l o t s = v a l u e ; }  
             i f   ( R J F R _ s t a r t _ l o t s < M i n L o t s )   { R J F R _ s t a r t _ l o t s = M i n L o t s ; }  
             i f   ( R J F R _ d e l t a < = 0 )   { R J F R _ d e l t a = s l ; }  
             i f   ( R J F R _ t a r g e t _ u p p e r < = 0 )   {  
                   R J F R _ t a r g e t _ u p p e r = A c c o u n t E q u i t y ( ) + ( R J F R _ u n i t s * R J F R _ d e l t a ) ;  
                   P r i n t ( " F i x e d   R a t i o   M M :   U n i t s = > " , R J F R _ u n i t s , " ;   D e l t a = " , R J F R _ d e l t a , " ;   U p p e r   T a r g e t   E q u i t y = > " , R J F R _ t a r g e t _ u p p e r ) ;  
             }  
             i f   ( A c c o u n t E q u i t y ( ) > = R J F R _ t a r g e t _ u p p e r )  
             {  
                   w h i l e ( t r u e )   {  
                         P r i n t ( " F i x e d   R a t i o   M M   g o i n g   u p   t o   " , ( R J F R _ s t a r t _ l o t s * ( R J F R _ u n i t s + 1 ) ) , "   l o t s :   E q u i t y   i s   a b o v e   U p p e r   T a r g e t   E q u i t y   ( " , A c c o u n t E q u i t y ( ) , " > = " , R J F R _ t a r g e t _ u p p e r , " ) " ) ;  
                         R J F R _ u n i t s + + ;  
                         R J F R _ t a r g e t _ l o w e r = R J F R _ t a r g e t _ u p p e r ;  
                         R J F R _ t a r g e t _ u p p e r = R J F R _ t a r g e t _ u p p e r + ( R J F R _ u n i t s * R J F R _ d e l t a ) ;  
                         P r i n t ( " F i x e d   R a t i o   M M :   U n i t s = > " , R J F R _ u n i t s , " ;   D e l t a = " , R J F R _ d e l t a , " ;   L o w e r   T a r g e t   E q u i t y = > " , R J F R _ t a r g e t _ l o w e r , " ;   U p p e r   T a r g e t   E q u i t y = > " , R J F R _ t a r g e t _ u p p e r ) ;  
                         i f   ( A c c o u n t E q u i t y ( ) < R J F R _ t a r g e t _ u p p e r )   { b r e a k ; }  
                   }  
             }  
             e l s e   i f   ( A c c o u n t E q u i t y ( ) < = R J F R _ t a r g e t _ l o w e r )  
             {  
                   w h i l e ( t r u e )   {  
                   i f   ( A c c o u n t E q u i t y ( ) > R J F R _ t a r g e t _ l o w e r )   { b r e a k ; }  
                         i f   ( R J F R _ u n i t s > 1 )   {                    
                               P r i n t ( " F i x e d   R a t i o   M M   g o i n g   d o w n   t o   " , ( R J F R _ s t a r t _ l o t s * ( R J F R _ u n i t s - 1 ) ) , "   l o t s :   E q u i t y   i s   b e l o w   L o w e r   T a r g e t   E q u i t y   |   " ,   A c c o u n t E q u i t y ( ) , "   < =   " , R J F R _ t a r g e t _ l o w e r , " ) " ) ;  
                               R J F R _ t a r g e t _ u p p e r = R J F R _ t a r g e t _ l o w e r ;  
                               R J F R _ t a r g e t _ l o w e r = R J F R _ t a r g e t _ l o w e r - ( ( R J F R _ u n i t s - 1 ) * R J F R _ d e l t a ) ;  
                               R J F R _ u n i t s - - ;  
                               P r i n t ( " F i x e d   R a t i o   M M :   U n i t s = > " , R J F R _ u n i t s , " ;   D e l t a = " , R J F R _ d e l t a , " ;   L o w e r   T a r g e t   E q u i t y = > " , R J F R _ t a r g e t _ l o w e r , " ;   U p p e r   T a r g e t   E q u i t y = > " , R J F R _ t a r g e t _ u p p e r ) ;  
                         }   e l s e   { b r e a k ; }  
                   }  
             }  
             s i z e = R J F R _ s t a r t _ l o t s * R J F R _ u n i t s ;  
       }  
        
 	 i f   ( s i z e = = E M P T Y _ V A L U E )   { s i z e = 0 ; }  
 	  
       s i z e = M a t h R o u n d ( s i z e / L o t S t e p ) * L o t S t e p ;  
        
       s t a t i c   b o o l   a l e r t _ m i n _ l o t s = f a l s e ;  
       i f   ( s i z e < M i n L o t s   & &   a l e r t _ m i n _ l o t s = = f a l s e )   {  
             a l e r t _ m i n _ l o t s = t r u e ;  
             A l e r t ( " Y o u   w a n t   t o   t r a d e   " , s i z e , "   l o t ,   b u t   y o u r   b r o k e r ' s   m i n i m u m   i s   " , M i n L o t s , "   l o t .   T h e   t r a d e / o r d e r   w i l l   c o n t i n u e   w i t h   " , M i n L o t s , "   l o t   i n s t e a d   o f   " , s i z e , "   l o t .   T h e   s a m e   r u l e   w i l l   b e   a p p l i e d   f o r   n e x t   t r a d e s / o r d e r s   w i t h   d e s i r e d   l o t   s i z e   l o w e r   t h a n   t h e   m i n i m u m .   Y o u   w i l l   n o t   s e e   t h i s   m e s s a g e   a g a i n   u n t i l   y o u   r e s t a r t   t h e   p r o g r a m . " ) ;  
       }  
        
       i f   ( a l i g n = = " a l i g n " )   {  
             i f   ( s i z e < M i n L o t s )   { s i z e = M i n L o t s ; }  
             i f   ( s i z e > M a x L o t s )   { s i z e = M a x L o t s ; }  
       }  
        
       r e t u r n   ( s i z e ) ;  
 }  
  
 s t r i n g   E r r o r M e s s a g e ( i n t   e r r o r _ c o d e = - 1 )  
 {  
 	 s t r i n g   e   =   " " ;  
 	  
 	 i f   ( e r r o r _ c o d e   <   0 )   { e r r o r _ c o d e   =   G e t L a s t E r r o r ( ) ; }  
 	  
 	 s w i t c h ( e r r o r _ c o d e )  
 	 {  
 	 	 / / - -   c o d e s   r e t u r n e d   f r o m   t r a d e   s e r v e r  
 	 	 c a s e   0 : 	 r e t u r n ( " " ) ;  
 	 	 c a s e   1 : 	 e   =   " N o   e r r o r   r e t u r n e d " ;   b r e a k ;  
 	 	 c a s e   2 : 	 e   =   " C o m m o n   e r r o r " ;   b r e a k ;  
 	 	 c a s e   3 : 	 e   =   " I n v a l i d   t r a d e   p a r a m e t e r s " ;   b r e a k ;  
 	 	 c a s e   4 : 	 e   =   " T r a d e   s e r v e r   i s   b u s y " ;   b r e a k ;  
 	 	 c a s e   5 : 	 e   =   " O l d   v e r s i o n   o f   t h e   c l i e n t   t e r m i n a l " ;   b r e a k ;  
 	 	 c a s e   6 : 	 e   =   " N o   c o n n e c t i o n   w i t h   t r a d e   s e r v e r " ;   b r e a k ;  
 	 	 c a s e   7 : 	 e   =   " N o t   e n o u g h   r i g h t s " ;   b r e a k ;  
 	 	 c a s e   8 : 	 e   =   " T o o   f r e q u e n t   r e q u e s t s " ;   b r e a k ;  
 	 	 c a s e   9 : 	 e   =   " M a l f u n c t i o n a l   t r a d e   o p e r a t i o n   ( n e v e r   r e t u r n e d   e r r o r ) " ;   b r e a k ;  
 	 	 c a s e   6 4 :     e   =   " A c c o u n t   d i s a b l e d " ;   b r e a k ;  
 	 	 c a s e   6 5 :     e   =   " I n v a l i d   a c c o u n t " ;   b r e a k ;  
 	 	 c a s e   1 2 8 :   e   =   " T r a d e   t i m e o u t " ;   b r e a k ;  
 	 	 c a s e   1 2 9 :   e   =   " I n v a l i d   p r i c e " ;   b r e a k ;  
 	 	 c a s e   1 3 0 :   e   =   " I n v a l i d   S l   o r   T P " ;   b r e a k ;  
 	 	 c a s e   1 3 1 :   e   =   " I n v a l i d   t r a d e   v o l u m e " ;   b r e a k ;  
 	 	 c a s e   1 3 2 :   e   =   " M a r k e t   i s   c l o s e d " ;   b r e a k ;  
 	 	 c a s e   1 3 3 :   e   =   " T r a d e   i s   d i s a b l e d " ;   b r e a k ;  
 	 	 c a s e   1 3 4 :   e   =   " N o t   e n o u g h   m o n e y " ;   b r e a k ;  
 	 	 c a s e   1 3 5 :   e   =   " P r i c e   c h a n g e d " ;   b r e a k ;  
 	 	 c a s e   1 3 6 :   e   =   " O f f   q u o t e s " ;   b r e a k ;  
 	 	 c a s e   1 3 7 :   e   =   " B r o k e r   i s   b u s y   ( n e v e r   r e t u r n e d   e r r o r ) " ;   b r e a k ;  
 	 	 c a s e   1 3 8 :   e   =   " R e q u o t e " ;   b r e a k ;  
 	 	 c a s e   1 3 9 :   e   =   " O r d e r   i s   l o c k e d " ;   b r e a k ;  
 	 	 c a s e   1 4 0 :   e   =   " O n l y   l o n g   t r a d e s   a l l o w e d " ;   b r e a k ;  
 	 	 c a s e   1 4 1 :   e   =   " T o o   m a n y   r e q u e s t s " ;   b r e a k ;  
 	 	 c a s e   1 4 5 :   e   =   " M o d i f i c a t i o n   d e n i e d   b e c a u s e   o r d e r   t o o   c l o s e   t o   m a r k e t " ;   b r e a k ;  
 	 	 c a s e   1 4 6 :   e   =   " T r a d e   c o n t e x t   i s   b u s y " ;   b r e a k ;  
 	 	 c a s e   1 4 7 :   e   =   " E x p i r a t i o n s   a r e   d e n i e d   b y   b r o k e r " ;   b r e a k ;  
 	 	 c a s e   1 4 8 :   e   =   " A m o u n t   o f   o p e n   a n d   p e n d i n g   o r d e r s   h a s   r e a c h e d   t h e   l i m i t " ;   b r e a k ;  
 	 	 c a s e   1 4 9 :   e   =   " H e d g i n g   i s   p r o h i b i t e d " ;   b r e a k ;  
 	 	 c a s e   1 5 0 :   e   =   " P r o h i b i t e d   b y   F I F O   r u l e s " ;   b r e a k ;  
 	 	  
 	 	 / / - -   m q l 4   e r r o r s  
 	 	 c a s e   4 0 0 0 :   e   =   " N o   e r r o r " ;   b r e a k ;  
 	 	 c a s e   4 0 0 1 :   e   =   " W r o n g   f u n c t i o n   p o i n t e r " ;   b r e a k ;  
 	 	 c a s e   4 0 0 2 :   e   =   " A r r a y   i n d e x   i s   o u t   o f   r a n g e " ;   b r e a k ;  
 	 	 c a s e   4 0 0 3 :   e   =   " N o   m e m o r y   f o r   f u n c t i o n   c a l l   s t a c k " ;   b r e a k ;  
 	 	 c a s e   4 0 0 4 :   e   =   " R e c u r s i v e   s t a c k   o v e r f l o w " ;   b r e a k ;  
 	 	 c a s e   4 0 0 5 :   e   =   " N o t   e n o u g h   s t a c k   f o r   p a r a m e t e r " ;   b r e a k ;  
 	 	 c a s e   4 0 0 6 :   e   =   " N o   m e m o r y   f o r   p a r a m e t e r   s t r i n g " ;   b r e a k ;  
 	 	 c a s e   4 0 0 7 :   e   =   " N o   m e m o r y   f o r   t e m p   s t r i n g " ;   b r e a k ;  
 	 	 c a s e   4 0 0 8 :   e   =   " N o t   i n i t i a l i z e d   s t r i n g " ;   b r e a k ;  
 	 	 c a s e   4 0 0 9 :   e   =   " N o t   i n i t i a l i z e d   s t r i n g   i n   a r r a y " ;   b r e a k ;  
 	 	 c a s e   4 0 1 0 :   e   =   " N o   m e m o r y   f o r   a r r a y   s t r i n g " ;   b r e a k ;  
 	 	 c a s e   4 0 1 1 :   e   =   " T o o   l o n g   s t r i n g " ;   b r e a k ;  
 	 	 c a s e   4 0 1 2 :   e   =   " R e m a i n d e r   f r o m   z e r o   d i v i d e " ;   b r e a k ;  
 	 	 c a s e   4 0 1 3 :   e   =   " Z e r o   d i v i d e " ;   b r e a k ;  
 	 	 c a s e   4 0 1 4 :   e   =   " U n k n o w n   c o m m a n d " ;   b r e a k ;  
 	 	 c a s e   4 0 1 5 :   e   =   " W r o n g   j u m p " ;   b r e a k ;  
 	 	 c a s e   4 0 1 6 :   e   =   " N o t   i n i t i a l i z e d   a r r a y " ;   b r e a k ;  
 	 	 c a s e   4 0 1 7 :   e   =   " d l l   c a l l s   a r e   n o t   a l l o w e d " ;   b r e a k ;  
 	 	 c a s e   4 0 1 8 :   e   =   " C a n n o t   l o a d   l i b r a r y " ;   b r e a k ;  
 	 	 c a s e   4 0 1 9 :   e   =   " C a n n o t   c a l l   f u n c t i o n " ;   b r e a k ;  
 	 	 c a s e   4 0 2 0 :   e   =   " E x p e r t   f u n c t i o n   c a l l s   a r e   n o t   a l l o w e d " ;   b r e a k ;  
 	 	 c a s e   4 0 2 1 :   e   =   " N o t   e n o u g h   m e m o r y   f o r   t e m p   s t r i n g   r e t u r n e d   f r o m   f u n c t i o n " ;   b r e a k ;  
 	 	 c a s e   4 0 2 2 :   e   =   " S y s t e m   i s   b u s y " ;   b r e a k ;  
 	 	 c a s e   4 0 5 0 :   e   =   " I n v a l i d   f u n c t i o n   p a r a m e t e r s   c o u n t " ;   b r e a k ;  
 	 	 c a s e   4 0 5 1 :   e   =   " I n v a l i d   f u n c t i o n   p a r a m e t e r   v a l u e " ;   b r e a k ;  
 	 	 c a s e   4 0 5 2 :   e   =   " S t r i n g   f u n c t i o n   i n t e r n a l   e r r o r " ;   b r e a k ;  
 	 	 c a s e   4 0 5 3 :   e   =   " S o m e   a r r a y   e r r o r " ;   b r e a k ;  
 	 	 c a s e   4 0 5 4 :   e   =   " I n c o r r e c t   s e r i e s   a r r a y   u s i n g " ;   b r e a k ;  
 	 	 c a s e   4 0 5 5 :   e   =   " C u s t o m   i n d i c a t o r   e r r o r " ;   b r e a k ;  
 	 	 c a s e   4 0 5 6 :   e   =   " A r r a y s   a r e   i n c o m p a t i b l e " ;   b r e a k ;  
 	 	 c a s e   4 0 5 7 :   e   =   " G l o b a l   v a r i a b l e s   p r o c e s s i n g   e r r o r " ;   b r e a k ;  
 	 	 c a s e   4 0 5 8 :   e   =   " G l o b a l   v a r i a b l e   n o t   f o u n d " ;   b r e a k ;  
 	 	 c a s e   4 0 5 9 :   e   =   " F u n c t i o n   i s   n o t   a l l o w e d   i n   t e s t i n g   m o d e " ;   b r e a k ;  
 	 	 c a s e   4 0 6 0 :   e   =   " F u n c t i o n   i s   n o t   c o n f i r m e d " ;   b r e a k ;  
 	 	 c a s e   4 0 6 1 :   e   =   " S e n d   m a i l   e r r o r " ;   b r e a k ;  
 	 	 c a s e   4 0 6 2 :   e   =   " S t r i n g   p a r a m e t e r   e x p e c t e d " ;   b r e a k ;  
 	 	 c a s e   4 0 6 3 :   e   =   " I n t e g e r   p a r a m e t e r   e x p e c t e d " ;   b r e a k ;  
 	 	 c a s e   4 0 6 4 :   e   =   " D o u b l e   p a r a m e t e r   e x p e c t e d " ;   b r e a k ;  
 	 	 c a s e   4 0 6 5 :   e   =   " A r r a y   a s   p a r a m e t e r   e x p e c t e d " ;   b r e a k ;  
 	 	 c a s e   4 0 6 6 :   e   =   " R e q u e s t e d   h i s t o r y   d a t a   i n   u p d a t e   s t a t e " ;   b r e a k ;  
 	 	 c a s e   4 0 9 9 :   e   =   " E n d   o f   f i l e " ;   b r e a k ;  
 	 	 c a s e   4 1 0 0 :   e   =   " S o m e   f i l e   e r r o r " ;   b r e a k ;  
 	 	 c a s e   4 1 0 1 :   e   =   " W r o n g   f i l e   n a m e " ;   b r e a k ;  
 	 	 c a s e   4 1 0 2 :   e   =   " T o o   m a n y   o p e n e d   f i l e s " ;   b r e a k ;  
 	 	 c a s e   4 1 0 3 :   e   =   " C a n n o t   o p e n   f i l e " ;   b r e a k ;  
 	 	 c a s e   4 1 0 4 :   e   =   " I n c o m p a t i b l e   a c c e s s   t o   a   f i l e " ;   b r e a k ;  
 	 	 c a s e   4 1 0 5 :   e   =   " N o   o r d e r   s e l e c t e d " ;   b r e a k ;  
 	 	 c a s e   4 1 0 6 :   e   =   " U n k n o w n   s y m b o l " ;   b r e a k ;  
 	 	 c a s e   4 1 0 7 :   e   =   " I n v a l i d   p r i c e   p a r a m e t e r   f o r   t r a d e   f u n c t i o n " ;   b r e a k ;  
 	 	 c a s e   4 1 0 8 :   e   =   " I n v a l i d   t i c k e t " ;   b r e a k ;  
 	 	 c a s e   4 1 0 9 :   e   =   " T r a d e   i s   n o t   a l l o w e d   i n   t h e   e x p e r t   p r o p e r t i e s " ;   b r e a k ;  
 	 	 c a s e   4 1 1 0 :   e   =   " L o n g s   a r e   n o t   a l l o w e d   i n   t h e   e x p e r t   p r o p e r t i e s " ;   b r e a k ;  
 	 	 c a s e   4 1 1 1 :   e   =   " S h o r t s   a r e   n o t   a l l o w e d   i n   t h e   e x p e r t   p r o p e r t i e s " ;   b r e a k ;  
 	 	  
 	 	 / / - -   o b j e c t s   e r r o r s  
 	 	 c a s e   4 2 0 0 :   e   =   " O b j e c t   i s   a l r e a d y   e x i s t " ;   b r e a k ;  
 	 	 c a s e   4 2 0 1 :   e   =   " U n k n o w n   o b j e c t   p r o p e r t y " ;   b r e a k ;  
 	 	 c a s e   4 2 0 2 :   e   =   " O b j e c t   i s   n o t   e x i s t " ;   b r e a k ;  
 	 	 c a s e   4 2 0 3 :   e   =   " U n k n o w n   o b j e c t   t y p e " ;   b r e a k ;  
 	 	 c a s e   4 2 0 4 :   e   =   " N o   o b j e c t   n a m e " ;   b r e a k ;  
 	 	 c a s e   4 2 0 5 :   e   =   " O b j e c t   c o o r d i n a t e s   e r r o r " ;   b r e a k ;  
 	 	 c a s e   4 2 0 6 :   e   =   " N o   s p e c i f i e d   s u b w i n d o w " ;   b r e a k ;  
 	 	 c a s e   4 2 0 7 :   e   =   " G r a p h i c a l   o b j e c t   e r r o r " ;   b r e a k ;      
 	 	 c a s e   4 2 1 0 :   e   =   " U n k n o w n   c h a r t   p r o p e r t y " ;   b r e a k ;  
 	 	 c a s e   4 2 1 1 :   e   =   " C h a r t   n o t   f o u n d " ;   b r e a k ;  
 	 	 c a s e   4 2 1 2 :   e   =   " C h a r t   s u b w i n d o w   n o t   f o u n d " ;   b r e a k ;  
 	 	 c a s e   4 2 1 3 :   e   =   " C h a r t   i n d i c a t o r   n o t   f o u n d " ;   b r e a k ;  
 	 	 c a s e   4 2 2 0 :   e   =   " S y m b o l   s e l e c t   e r r o r " ;   b r e a k ;  
 	 	 c a s e   4 2 5 0 :   e   =   " N o t i f i c a t i o n   e r r o r " ;   b r e a k ;  
 	 	 c a s e   4 2 5 1 :   e   =   " N o t i f i c a t i o n   p a r a m e t e r   e r r o r " ;   b r e a k ;  
 	 	 c a s e   4 2 5 2 :   e   =   " N o t i f i c a t i o n s   d i s a b l e d " ;   b r e a k ;  
 	 	 c a s e   4 2 5 3 :   e   =   " N o t i f i c a t i o n   s e n d   t o o   f r e q u e n t " ;   b r e a k ;  
 	 	  
 	 	 / / - -   f t p   e r r o r s  
 	 	 c a s e   4 2 6 0 :   e   =   " F T P   s e r v e r   i s   n o t   s p e c i f i e d " ;   b r e a k ;  
 	 	 c a s e   4 2 6 1 :   e   =   " F T P   l o g i n   i s   n o t   s p e c i f i e d " ;   b r e a k ;  
 	 	 c a s e   4 2 6 2 :   e   =   " F T P   c o n n e c t i o n   f a i l e d " ;   b r e a k ;  
 	 	 c a s e   4 2 6 3 :   e   =   " F T P   c o n n e c t i o n   c l o s e d " ;   b r e a k ;  
 	 	 c a s e   4 2 6 4 :   e   =   " F T P   p a t h   n o t   f o u n d   o n   s e r v e r " ;   b r e a k ;  
 	 	 c a s e   4 2 6 5 :   e   =   " F i l e   n o t   f o u n d   i n   t h e   M Q L 4 \ \ F i l e s   d i r e c t o r y   t o   s e n d   o n   F T P   s e r v e r " ;   b r e a k ;  
 	 	 c a s e   4 2 6 6 :   e   =   " C o m m o n   e r r o r   d u r i n g   F T P   d a t a   t r a n s m i s s i o n " ;   b r e a k ;  
 	 	  
 	 	 / / - -   f i l e s y s t e m   e r r o r s  
 	 	 c a s e   5 0 0 1 :   e   =   " T o o   m a n y   o p e n e d   f i l e s " ;   b r e a k ;  
 	 	 c a s e   5 0 0 2 :   e   =   " W r o n g   f i l e   n a m e " ;   b r e a k ;  
 	 	 c a s e   5 0 0 3 :   e   =   " T o o   l o n g   f i l e   n a m e " ;   b r e a k ;  
 	 	 c a s e   5 0 0 4 :   e   =   " C a n n o t   o p e n   f i l e " ;   b r e a k ;  
 	 	 c a s e   5 0 0 5 :   e   =   " T e x t   f i l e   b u f f e r   a l l o c a t i o n   e r r o r " ;   b r e a k ;  
 	 	 c a s e   5 0 0 6 :   e   =   " C a n n o t   d e l e t e   f i l e " ;   b r e a k ;  
 	 	 c a s e   5 0 0 7 :   e   =   " I n v a l i d   f i l e   h a n d l e   ( f i l e   c l o s e d   o r   w a s   n o t   o p e n e d ) " ;   b r e a k ;  
 	 	 c a s e   5 0 0 8 :   e   =   " W r o n g   f i l e   h a n d l e   ( h a n d l e   i n d e x   i s   o u t   o f   h a n d l e   t a b l e ) " ;   b r e a k ;  
 	 	 c a s e   5 0 0 9 :   e   =   " F i l e   m u s t   b e   o p e n e d   w i t h   F I L E _ W R I T E   f l a g " ;   b r e a k ;  
 	 	 c a s e   5 0 1 0 :   e   =   " F i l e   m u s t   b e   o p e n e d   w i t h   F I L E _ R E A D   f l a g " ;   b r e a k ;  
 	 	 c a s e   5 0 1 1 :   e   =   " F i l e   m u s t   b e   o p e n e d   w i t h   F I L E _ B I N   f l a g " ;   b r e a k ;  
 	 	 c a s e   5 0 1 2 :   e   =   " F i l e   m u s t   b e   o p e n e d   w i t h   F I L E _ T X T   f l a g " ;   b r e a k ;  
 	 	 c a s e   5 0 1 3 :   e   =   " F i l e   m u s t   b e   o p e n e d   w i t h   F I L E _ T X T   o r   F I L E _ C S V   f l a g " ;   b r e a k ;  
 	 	 c a s e   5 0 1 4 :   e   =   " F i l e   m u s t   b e   o p e n e d   w i t h   F I L E _ C S V   f l a g " ;   b r e a k ;  
 	 	 c a s e   5 0 1 5 :   e   =   " F i l e   r e a d   e r r o r " ;   b r e a k ;  
 	 	 c a s e   5 0 1 6 :   e   =   " F i l e   w r i t e   e r r o r " ;   b r e a k ;  
 	 	 c a s e   5 0 1 7 :   e   =   " S t r i n g   s i z e   m u s t   b e   s p e c i f i e d   f o r   b i n a r y   f i l e " ;   b r e a k ;  
 	 	 c a s e   5 0 1 8 :   e   =   " I n c o m p a t i b l e   f i l e   ( f o r   s t r i n g   a r r a y s - T X T ,   f o r   o t h e r s - B I N ) " ;   b r e a k ;  
 	 	 c a s e   5 0 1 9 :   e   =   " F i l e   i s   d i r e c t o r y ,   n o t   f i l e " ;   b r e a k ;  
 	 	 c a s e   5 0 2 0 :   e   =   " F i l e   d o e s   n o t   e x i s t " ;   b r e a k ;  
 	 	 c a s e   5 0 2 1 :   e   =   " F i l e   c a n n o t   b e   r e w r i t t e n " ;   b r e a k ;  
 	 	 c a s e   5 0 2 2 :   e   =   " W r o n g   d i r e c t o r y   n a m e " ;   b r e a k ;  
 	 	 c a s e   5 0 2 3 :   e   =   " D i r e c t o r y   d o e s   n o t   e x i s t " ;   b r e a k ;  
 	 	 c a s e   5 0 2 4 :   e   =   " S p e c i f i e d   f i l e   i s   n o t   d i r e c t o r y " ;   b r e a k ;  
 	 	 c a s e   5 0 2 5 :   e   =   " C a n n o t   d e l e t e   d i r e c t o r y " ;   b r e a k ;  
 	 	 c a s e   5 0 2 6 :   e   =   " C a n n o t   c l e a n   d i r e c t o r y " ;   b r e a k ;  
 	 	  
 	 	 / / - -   o t h e r   e r r o r s  
 	 	 c a s e   5 0 2 7 :   e   =   " A r r a y   r e s i z e   e r r o r " ;   b r e a k ;  
 	 	 c a s e   5 0 2 8 :   e   =   " S t r i n g   r e s i z e   e r r o r " ;   b r e a k ;  
 	 	 c a s e   5 0 2 9 :   e   =   " S t r u c t u r e   c o n t a i n s   s t r i n g s   o r   d y n a m i c   a r r a y s " ;   b r e a k ;  
 	 	  
 	 	 / / - -   h t t p   r e q u e s t  
 	 	 c a s e   5 2 0 0 :   e   =   " I n v a l i d   U R L " ;   b r e a k ;  
 	 	 c a s e   5 2 0 1 :   e   =   " F a i l e d   t o   c o n n e c t   t o   s p e c i f i e d   U R L " ;   b r e a k ;  
 	 	 c a s e   5 2 0 2 :   e   =   " T i m e o u t   e x c e e d e d " ;   b r e a k ;  
 	 	 c a s e   5 2 0 3 :   e   =   " H T T P   r e q u e s t   f a i l e d " ;   b r e a k ;  
  
 	 	 d e f a u l t : 	 e   =   " U n k n o w n   e r r o r " ;  
 	 }  
  
 	 e   =   S t r i n g C o n c a t e n a t e ( e ,   "   ( " ,   e r r o r _ c o d e ,   " ) " ) ;  
 	  
 	 r e t u r n   e ;  
 }  
  
 v o i d   E x p i r a t i o n D r i v e r ( )  
 {  
 	 s t a t i c   i n t   l a s t _ c h e c k e d _ t i c k e t ;  
 	 s t a t i c   i n t   d b _ t i c k e t s [ ] ;  
 	 s t a t i c   d a t e t i m e   d b _ e x p i r a t i o n s [ ] ;  
  
 	 i n t   t o t a l         =   O r d e r s T o t a l ( ) ;  
 	 i n t   s i z e           =   0 ;  
 	 i n t   d o _ r e s e t   =   f a l s e ;  
 	 s t r i n g   p r i n t ;  
 	 i n t   i ;  
  
 	 / / - -   c h e c k   e x p i r a t i o n s   a n d   c l o s e   t r a d e s  
 	 s i z e   =   A r r a y S i z e ( d b _ t i c k e t s ) ;  
  
 	 i f   ( s i z e   >   0 )  
 	 {  
 	 	 i f   ( t o t a l = = 0 )  
 	 	 {  
 	 	 	 A r r a y R e s i z e ( d b _ t i c k e t s ,   0 ) ;  
 	 	 	 A r r a y R e s i z e ( d b _ e x p i r a t i o n s ,   0 ) ;  
 	 	 }  
 	 	 e l s e  
 	 	 {  
 	 	 	 f o r   ( i   =   0 ;   i   <   s i z e ;   i + + )  
 	 	 	 {  
 	 	 	 	 W a i t T r a d e C o n t e x t I f B u s y ( ) ;  
  
 	 	 	 	 i f   ( ! O r d e r S e l e c t ( d b _ t i c k e t s [ i ] ,   S E L E C T _ B Y _ T I C K E T ,   M O D E _ T R A D E S ) )   { c o n t i n u e ; }  
 	 	 	 	 i f   ( O r d e r S y m b o l ( )   ! =   S y m b o l ( ) )   { c o n t i n u e ; }  
 	 	 	 	  
 	 	 	 	 i f   ( T i m e C u r r e n t ( )   > =   d b _ e x p i r a t i o n s [ i ] )  
 	 	 	 	 {  
 	 	 	 	 	 / / - -   t r y i n g   t o   s k i p   c o n f l i c t s   w i t h   t h e   s a m e   f u n c t i o n a l i t y   r u n n i n g   f r o m   n e i g h b o u r   E A  
 	 	 	 	 	 W a i t T r a d e C o n t e x t I f B u s y ( ) ;  
  
 	 	 	 	 	 i f   ( ! O r d e r S e l e c t ( d b _ t i c k e t s [ i ] , S E L E C T _ B Y _ T I C K E T ,   M O D E _ T R A D E S ) )   { c o n t i n u e ; }  
 	 	 	 	 	 i f   ( O r d e r C l o s e T i m e ( )   >   0 )   { c o n t i n u e ; }  
  
 	 	 	 	 	 / / - -   c l o s i n g   t h e   t r a d e  
 	 	 	 	 	 i f   ( C l o s e T r a d e ( O r d e r T i c k e t ( ) ) )    
 	 	 	 	 	 {  
 	 	 	 	 	 	 p r i n t   =   " # "   +   ( s t r i n g ) O r d e r T i c k e t ( )   +   "   w a s   c l o s e d   d u e   t o   e x p i r a t i o n " ;  
 	 	 	 	 	 	 P r i n t ( p r i n t ) ;  
 	 	 	 	 	 	 l a s t _ c h e c k e d _ t i c k e t   =   0 ;  
 	 	 	 	 	 	 d o _ r e s e t   =   t r u e ;  
 	 	 	 	 	 	 t o t a l         =   O r d e r s T o t a l ( ) ;  
 	 	 	 	 	 }  
 	 	 	 	 }  
 	 	 	 }  
 	 	 }  
 	 }  
  
 	 / / - -   c h e c k   t h e   t i c k e t   o f   t h e   n e w e s t   t r a d e  
 	 i f   ( d o _ r e s e t   = =   f a l s e   & &   t o t a l   >   0 )  
 	 {  
 	 	 i f   ( O r d e r S e l e c t ( t o t a l - 1 ,   S E L E C T _ B Y _ P O S ) )  
 	 	 {  
 	 	 	 i f   ( O r d e r T i c k e t ( )   ! =   l a s t _ c h e c k e d _ t i c k e t )  
 	 	 	 {  
 	 	 	 	 d o _ r e s e t   =   t r u e ;  
 	 	 	 }  
 	 	 }  
 	 }  
  
 	 / / - -   r e b u i l d   t h e   d a t a b a s e   o f   t r a d e s   w i t h   e x p i r a t i o n s  
 	 i f   ( d o _ r e s e t   = =   t r u e )  
 	 {  
 	 	 A r r a y R e s i z e ( d b _ t i c k e t s ,   0 ) ;  
 	 	 A r r a y R e s i z e ( d b _ e x p i r a t i o n s ,   0 ) ;  
  
 	 	 f o r   ( i n t   p o s   =   0 ;   p o s   <   t o t a l ;   p o s + + )  
 	 	 {  
 	 	 	 i f   ( ! O r d e r S e l e c t ( p o s ,   S E L E C T _ B Y _ P O S ) )   { c o n t i n u e ; }  
 	 	 	 l a s t _ c h e c k e d _ t i c k e t   =   O r d e r T i c k e t ( ) ;  
  
 	 	 	 s t r i n g   c o m m e n t   =   O r d e r C o m m e n t ( ) ;  
 	 	 	 i n t   e x p _ p o s _ b e g i n   =   S t r i n g F i n d ( c o m m e n t ,   " [ e x p : " ) ;  
  
 	 	 	 i f   ( e x p _ p o s _ b e g i n   > =   0 )  
 	 	 	 {  
 	 	 	 	 e x p _ p o s _ b e g i n   =   e x p _ p o s _ b e g i n   +   5 ;  
 	 	 	 	 i n t   e x p _ p o s _ e n d   =   S t r i n g F i n d ( c o m m e n t ,   " ] " ,   e x p _ p o s _ b e g i n ) ;  
 	 	 	 	 i f   ( e x p _ p o s _ e n d   = =   - 1 )   { c o n t i n u e ; }  
 	 	 	 	  
 	 	 	 	 s i z e   =   A r r a y S i z e ( d b _ t i c k e t s ) ;  
 	 	 	 	 A r r a y R e s i z e ( d b _ t i c k e t s ,   s i z e + 1 ) ;  
 	 	 	 	 A r r a y R e s i z e ( d b _ e x p i r a t i o n s ,   s i z e + 1 ) ;  
  
 	 	 	 	 d b _ t i c k e t s [ s i z e ]           =   O r d e r T i c k e t ( ) ;  
 	 	 	 	 d b _ e x p i r a t i o n s [ s i z e ]   =   ( d a t e t i m e ) ( ( i n t ) O r d e r O p e n T i m e ( )   +   ( i n t ) S t r i n g T o I n t e g e r ( S t r i n g S u b s t r ( c o m m e n t ,   e x p _ p o s _ b e g i n ,   e x p _ p o s _ e n d ) ) ) ;  
 	 	 	 }  
 	 	 }  
 	 }  
 }  
  
 d a t e t i m e   E x p i r a t i o n T i m e ( s t r i n g   m o d e = " G T C " , i n t   d a y s = 0 ,   i n t   h o u r s = 0 ,   i n t   m i n u t e s = 0 ,   d a t e t i m e   c u s t o m = 0 )  
 {  
 	 d a t e t i m e   n o w                 =   T i m e C u r r e n t ( ) ;  
       d a t e t i m e   e x p i r a t i o n   =   n o w ;  
  
 	           i f   ( m o d e   = =   " G T C "   | |   m o d e   = =   " " )   { e x p i r a t i o n   =   0 ; }  
 	 e l s e   i f   ( m o d e   = =   " t o d a y " )                           { e x p i r a t i o n   =   ( d a t e t i m e ) ( M a t h F l o o r ( ( n o w   +   8 6 4 0 0 . 0 )   /   8 6 4 0 0 . 0 )   *   8 6 4 0 0 . 0 ) ; }  
 	 e l s e   i f   ( m o d e   = =   " s p e c i f i e d " )  
 	 {  
 	 	 e x p i r a t i o n   =   0 ;  
  
 	 	 i f   ( ( d a y s   +   h o u r s   +   m i n u t e s )   >   0 )  
 	 	 {  
 	 	 	 e x p i r a t i o n   =   n o w   +   ( 8 6 4 0 0   *   d a y s )   +   ( 3 6 0 0   *   h o u r s )   +   ( 6 0   *   m i n u t e s ) ;  
 	 	 }  
 	 }  
 	 e l s e  
 	 {  
 	 	 i f   ( c u s t o m   < =   n o w )  
 	 	 {  
 	 	 	 i f   ( c u s t o m   <   3 1 5 5 7 6 0 0 )  
 	 	 	 {  
 	 	 	 	 c u s t o m   =   n o w   +   c u s t o m ;  
 	 	 	 }  
 	 	 	 e l s e  
 	 	 	 {  
 	 	 	 	 c u s t o m   =   0 ;  
 	 	 	 }  
 	 	 }  
  
 	 	 e x p i r a t i o n   =   c u s t o m ;  
 	 }  
  
 	 r e t u r n   e x p i r a t i o n ;  
 }  
  
 b o o l   F i l t e r O r d e r B y (  
 	 s t r i n g   g r o u p _ m o d e         =   " a l l " ,  
 	 s t r i n g   g r o u p                   =   " 0 " ,  
 	 s t r i n g   m a r k e t _ m o d e       =   " a l l " ,  
 	 s t r i n g   m a r k e t                 =   " " ,  
 	 s t r i n g   B u y s O r S e l l s       =   " b o t h " ,  
 	 s t r i n g   L i m i t s O r S t o p s   =   " b o t h " ,  
 	 i n t   T r a d e s O r d e r s           =   0 ,  
 	 b o o l   o n T r a d e                   =   f a l s e  
 )   {  
 	 / /   T r a d e s O r d e r s   =   0   -   t r a d e s   o n l y  
 	 / /   T r a d e s O r d e r s   =   1   -   o r d e r s   o n l y  
 	 / /   T r a d e s O r d e r s   =   2   -   t r a d e s   a n d   o r d e r s  
  
 	 / / - -   d b  
 	 s t a t i c   s t r i n g   m a r k e t s [ ] ;  
 	 s t a t i c   s t r i n g   m a r k e t 0       =   " - " ;  
 	 s t a t i c   i n t   m a r k e t s _ s i z e   =   0 ;  
 	  
 	 s t a t i c   s t r i n g   g r o u p s [ ] ;  
 	 s t a t i c   s t r i n g   g r o u p 0       =   " - " ;  
 	 s t a t i c   i n t   g r o u p s _ s i z e   =   0 ;  
 	  
 	 / / - -   l o c a l   v a r i a b l e s  
 	 b o o l   t y p e _ p a s s       =   f a l s e ;  
 	 b o o l   m a r k e t _ p a s s   =   f a l s e ;  
 	 b o o l   g r o u p _ p a s s     =   f a l s e ;  
 	  
 	 i n t   i ,   t y p e ,   m a g i c _ n u m b e r ;  
 	 s t r i n g   s y m b o l ;  
  
 	 / /   T r a d e s  
 	 i f   ( o n T r a d e   = =   f a l s e )  
 	 {  
 	 	 t y p e                   =   O r d e r T y p e ( ) ;  
 	 	 m a g i c _ n u m b e r   =   O r d e r M a g i c N u m b e r ( ) ;  
 	 	 s y m b o l               =   O r d e r S y m b o l ( ) ;  
 	 }  
 	 e l s e  
 	 {  
 	 	 t y p e                   =   e _ a t t r T y p e ( ) ;  
 	 	 m a g i c _ n u m b e r   =   e _ a t t r M a g i c N u m b e r ( ) ;  
 	 	 s y m b o l               =   e _ a t t r S y m b o l ( ) ;  
 	 }  
  
 	 i f   ( T r a d e s O r d e r s   = =   0 )  
 	 {  
 	 	 i f   (  
 	 	 	 	 ( B u y s O r S e l l s   = =   " b o t h "     & &   ( t y p e   = =   O P _ B U Y   | |   t y p e   = =   O P _ S E L L ) )  
 	 	 	 | |   ( B u y s O r S e l l s   = =   " b u y s "     & &   t y p e   = =   O P _ B U Y )  
 	 	 	 | |   ( B u y s O r S e l l s   = =   " s e l l s "   & &   t y p e   = =   O P _ S E L L )  
 	 	 	  
 	 	 	 )  
 	 	 {  
 	 	 	 t y p e _ p a s s   =   t r u e ;  
 	 	 }  
 	 }  
 	 / /   P e n d i n g   o r d e r s  
 	 e l s e   i f   ( T r a d e s O r d e r s   = =   1 )  
 	 {  
 	 	 i f   (  
 	 	 	 	 ( B u y s O r S e l l s   = =   " b o t h "   & &   ( t y p e   = =   O P _ B U Y L I M I T   | |   t y p e   = =   O P _ B U Y S T O P   | |   t y p e   = =   O P _ S E L L L I M I T   | |   t y p e   = =   O P _ S E L L S T O P ) )  
 	 	 	 | | 	 ( B u y s O r S e l l s   = =   " b u y s "   & &   ( t y p e   = =   O P _ B U Y L I M I T   | |   t y p e   = =   O P _ B U Y S T O P ) )  
 	 	 	 | |   ( B u y s O r S e l l s   = =   " s e l l s "   & &   ( t y p e   = =   O P _ S E L L L I M I T   | |   t y p e   = =   O P _ S E L L S T O P ) )  
 	 	 	 )  
 	 	 {  
 	 	 	 i f   (  
 	 	 	 	 	 ( L i m i t s O r S t o p s   = =   " b o t h "   & &   ( t y p e   = =   O P _ B U Y S T O P   | |   t y p e   = =   O P _ S E L L S T O P   | |   t y p e   = =   O P _ B U Y L I M I T   | |   t y p e   = =   O P _ S E L L L I M I T ) )  
 	 	 	 	 | | 	 ( L i m i t s O r S t o p s   = =   " s t o p s "   & &   ( t y p e   = =   O P _ B U Y S T O P   | |   t y p e   = =   O P _ S E L L S T O P ) )  
 	 	 	 	 | |   ( L i m i t s O r S t o p s   = =   " l i m i t s "   & &   ( t y p e   = =   O P _ B U Y L I M I T   | |   t y p e   = =   O P _ S E L L L I M I T ) ) 	 	 	 	 	  
 	 	 	 	 )  
 	 	 	 {  
 	 	 	 	 t y p e _ p a s s   =   t r u e ;  
 	 	 	 }  
 	 	 }  
 	 }  
 	 / / - -   T r a d e s   a n d   o r d e r s   - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  
 	 e l s e  
 	 {  
 	 	 i f   (  
 	 	 	 	 ( B u y s O r S e l l s   = =   " b o t h " )  
 	 	 	 | |   ( B u y s O r S e l l s   = =   " b u y s "     & &   ( t y p e   = =   O P _ B U Y   | |   t y p e   = =   O P _ B U Y L I M I T   | |   t y p e   = =   O P _ B U Y S T O P ) )  
 	 	 	 | |   ( B u y s O r S e l l s   = =   " s e l l s "   & &   ( t y p e   = =   O P _ S E L L   | |   t y p e   = =   O P _ S E L L L I M I T   | |   t y p e   = =   O P _ S E L L S T O P ) )  
 	 	 	 )  
 	 	 {  
 	 	 	 t y p e _ p a s s   =   t r u e ;  
 	 	 }  
 	 }  
  
 	 i f   ( t y p e _ p a s s   = =   f a l s e )  
 	 {  
 	 	 r e t u r n   f a l s e ;  
 	 }  
  
 	 / / - -   c h e c k   g r o u p  
 	 i f   ( g r o u p _ m o d e   = =   " g r o u p " )  
 	 {  
 	 	 i f   ( g r o u p   = =   " " )  
 	 	 {  
 	 	 	 i f   ( m a g i c _ n u m b e r   = =   M a g i c S t a r t )  
       	 	 {  
       	 	 	 g r o u p _ p a s s   =   t r u e ;  
       	 	 }  
 	       }  
 	       e l s e  
 	       {  
 	 	 	 i f   ( g r o u p 0   ! =   g r o u p )  
 	 	 	 {  
 	 	 	 	 g r o u p 0   =   g r o u p ;  
 	 	 	 	 S t r i n g E x p l o d e ( " , " ,   g r o u p , g r o u p s ) ;  
 	 	 	 	 g r o u p s _ s i z e   =   A r r a y S i z e ( g r o u p s ) ;  
  
 	 	 	 	 f o r ( i   =   0 ;   i   <   g r o u p s _ s i z e ;   i + + )  
 	 	 	 	 {  
 	 	 	 	 	 g r o u p s [ i ]   =   S t r i n g T r i m R i g h t ( g r o u p s [ i ] ) ;  
 	 	 	 	 	 g r o u p s [ i ]   =   S t r i n g T r i m L e f t ( g r o u p s [ i ] ) ;  
  
 	 	 	 	 	 i f   ( g r o u p s [ i ]   = =   " " )   { g r o u p s [ i ]   =   " 0 " ; }  
 	 	 	 	 }  
 	 	 	 }  
 	 	  
 	 	 	 f o r ( i   =   0 ;   i   <   g r o u p s _ s i z e ;   i + + )  
 	 	 	 {  
 	 	 	 	 i f   ( m a g i c _ n u m b e r   = =   ( M a g i c S t a r t + ( i n t ) g r o u p s [ i ] ) )  
 	 	 	 	 {  
 	 	 	 	 	 g r o u p _ p a s s   =   t r u e ;  
  
 	 	 	 	 	 b r e a k ;  
 	 	 	 	 }  
 	 	 	 }  
 	 	 }  
 	 }  
 	 e l s e   i f   ( g r o u p _ m o d e   = =   " a l l "   | |   ( g r o u p _ m o d e   = =   " m a n u a l "   & &   m a g i c _ n u m b e r   = =   0 ) )  
 	 {  
 	 	 g r o u p _ p a s s   =   t r u e ;      
 	 }  
  
 	 i f   ( g r o u p _ p a s s   = =   f a l s e )  
 	 {  
 	 	 r e t u r n   f a l s e ;  
 	 }  
  
 	 / /   c h e c k   m a r k e t  
 	 i f   ( m a r k e t _ m o d e   = =   " a l l " )  
 	 {  
 	 	 m a r k e t _ p a s s   =   t r u e ;  
 	 }  
 	 e l s e  
 	 {  
 	 	 i f   ( s y m b o l   = =   m a r k e t )  
 	       {  
 	             m a r k e t _ p a s s   =   t r u e ;  
 	       }  
             e l s e  
             {  
 	 	 	 i f   ( m a r k e t 0   ! =   m a r k e t )  
 	 	 	 {  
 	 	 	 	 m a r k e t 0   =   m a r k e t ;  
  
 	 	 	 	 i f   ( m a r k e t   = =   " " )  
 	 	 	 	 {  
 	 	 	 	 	 m a r k e t s _ s i z e   =   1 ;  
 	 	 	 	 	 A r r a y R e s i z e ( m a r k e t s ,   1 ) ;  
 	 	 	 	 	 m a r k e t s [ 0 ]   =   S y m b o l ( ) ;  
 	 	 	 	 }  
 	 	 	 	 e l s e  
 	 	 	 	 {  
 	 	 	 	 	 S t r i n g E x p l o d e ( " , " ,   m a r k e t ,   m a r k e t s ) ;  
 	 	 	 	 	 m a r k e t s _ s i z e   =   A r r a y S i z e ( m a r k e t s ) ;  
  
 	 	 	 	 	 f o r ( i   =   0 ;   i   <   m a r k e t s _ s i z e ;   i + + )  
 	 	 	 	 	 {  
 	 	 	 	 	 	 m a r k e t s [ i ]   =   S t r i n g T r i m R i g h t ( m a r k e t s [ i ] ) ;  
 	 	 	 	 	 	 m a r k e t s [ i ]   =   S t r i n g T r i m L e f t ( m a r k e t s [ i ] ) ;  
  
 	 	 	 	 	 	 i f   ( m a r k e t s [ i ]   = =   " " )   { m a r k e t s [ i ]   =   S y m b o l ( ) ; }  
 	 	 	 	 	 }  
 	 	 	 	 }  
 	 	 	 }  
  
 	 	 	 f o r ( i   =   0 ;   i   <   m a r k e t s _ s i z e ;   i + + )  
 	 	 	 {  
 	 	 	 	 i f   ( s y m b o l   = =   m a r k e t s [ i ] )  
 	 	 	 	 {  
 	 	 	 	 	 m a r k e t _ p a s s   =   t r u e ;  
  
 	 	 	 	 	 b r e a k ;  
 	 	 	 	 }  
 	 	 	 }  
 	 	 }  
 	 }  
  
 	 i f   ( m a r k e t _ p a s s   = =   f a l s e )  
 	 {  
 	 	 r e t u r n   f a l s e ;  
 	 }  
  
 	 r e t u r n   t r u e ;  
 }  
  
 b o o l   H i s t o r y T r a d e S e l e c t B y I n d e x (  
 	 i n t   i n d e x ,  
 	 s t r i n g   g r o u p _ m o d e         =   " a l l " ,  
 	 s t r i n g   g r o u p                   =   " 0 " ,  
 	 s t r i n g   m a r k e t _ m o d e       =   " a l l " ,  
 	 s t r i n g   m a r k e t                 =   " " ,  
 	 s t r i n g   B u y s O r S e l l s       =   " b o t h "  
 )   {  
 	 i f   ( O r d e r S e l e c t ( ( i n t ) i n d e x ,   S E L E C T _ B Y _ P O S ,   M O D E _ H I S T O R Y )   & &   O r d e r T y p e ( )   <   2 )  
 	 {  
 	 	 i f   ( F i l t e r O r d e r B y (  
 	 	 	 g r o u p _ m o d e ,  
 	 	 	 g r o u p ,  
 	 	 	 m a r k e t _ m o d e ,  
 	 	 	 m a r k e t ,  
 	 	 	 B u y s O r S e l l s )  
 	 	 )   {  
 	 	 	 r e t u r n   t r u e ;  
 	 	 }  
 	 }  
  
 	 r e t u r n   f a l s e ;  
 }  
  
 i n t   H i s t o r y T r a d e s T o t a l ( d a t e t i m e   f r o m _ d a t e = 0 ,   d a t e t i m e   t o _ d a t e = 0 )  
 {  
 	 / /   b o t h   i n p u t   p a r a m e t e r s   a r e   d u m m y  
 	 / /   t h e y   e x i s t   o n l y   t o   m a k e   t h e   f u n c t i o n   c o m p a t i b l e   w i t h   M Q L 5 - l i k e   c o d e  
  
 	 r e t u r n   O r d e r s H i s t o r y T o t a l ( ) ;  
 }  
  
 t e m p l a t e < t y p e n a m e   T >  
 b o o l   I n A r r a y ( T   & a r r a y [ ] ,   T   v a l u e )  
 {  
 	 i n t   s i z e   =   A r r a y S i z e ( a r r a y ) ;  
  
 	 i f   ( s i z e   >   0 )  
 	 {  
 	 	 f o r   ( i n t   i   =   0 ;   i   <   s i z e ;   i + + )  
 	 	 {  
 	 	 	 i f   ( a r r a y [ i ]   = =   v a l u e )  
 	 	 	 {  
 	 	 	 	 r e t u r n   t r u e ;  
 	 	 	 }  
 	 	 }  
 	 }  
  
 	 r e t u r n   f a l s e ;  
 }  
  
 b o o l   I s O r d e r T y p e S e l l ( )  
 {  
 	 i n t   t y p e   =   O r d e r T y p e ( ) ;  
  
 	 r e t u r n   ( t y p e   = =   O P _ S E L L   | |   t y p e   = =   O P _ S E L L S T O P   | |   t y p e   = =   O P _ S E L L L I M I T ) ;  
 }  
  
 b o o l   M o d i f y O r d e r (  
 	 i n t   t i c k e t ,  
 	 d o u b l e   o p ,  
 	 d o u b l e   s l l   =   0 ,  
 	 d o u b l e   t p l   =   0 ,  
 	 d o u b l e   s l p   =   0 ,  
 	 d o u b l e   t p p   =   0 ,  
 	 d a t e t i m e   e x p   =   0 ,  
 	 c o l o r   c l r   =   c l r N O N E ,  
 	 b o o l   o n t r a d e _ e v e n t   =   t r u e  
 )   {  
 	 i n t   b s   =   1 ;  
  
 	 i f   (  
 	 	       O r d e r T y p e ( )   = =   O P _ S E L L  
 	 	 | |   O r d e r T y p e ( )   = =   O P _ S E L L S T O P  
 	 	 | |   O r d e r T y p e ( )   = =   O P _ S E L L L I M I T  
 	 )  
 	 { b s   =   - 1 ; }   / /   P o s i t i v e   w h e n   B u y ,   n e g a t i v e   w h e n   S e l l  
  
 	 w h i l e   ( t r u e )  
 	 {  
 	 	 u i n t   t i m e 0   =   G e t T i c k C o u n t ( ) ;  
  
 	 	 W a i t T r a d e C o n t e x t I f B u s y ( ) ;  
  
 	 	 i f   ( ! O r d e r S e l e c t ( t i c k e t , S E L E C T _ B Y _ T I C K E T ) )  
 	 	 {  
 	 	 	 r e t u r n   f a l s e ;  
 	 	 }  
  
 	 	 s t r i n g   s y m b o l             =   O r d e r S y m b o l ( ) ;  
 	 	 i n t   t y p e                       =   O r d e r T y p e ( ) ;  
 	 	 d o u b l e   a s k                   =   S y m b o l I n f o D o u b l e ( s y m b o l ,   S Y M B O L _ A S K ) ;  
 	 	 d o u b l e   b i d                   =   S y m b o l I n f o D o u b l e ( s y m b o l ,   S Y M B O L _ B I D ) ;  
 	 	 i n t   d i g i t s                   =   ( i n t ) S y m b o l I n f o I n t e g e r ( s y m b o l ,   S Y M B O L _ D I G I T S ) ;  
 	 	 d o u b l e   p o i n t               =   S y m b o l I n f o D o u b l e ( s y m b o l ,   S Y M B O L _ P O I N T ) ;  
 	 	 d o u b l e   s t o p l e v e l       =   p o i n t   *   S y m b o l I n f o I n t e g e r ( s y m b o l ,   S Y M B O L _ T R A D E _ S T O P S _ L E V E L ) ;  
 	 	 d o u b l e   f r e e z e l e v e l   =   p o i n t   *   S y m b o l I n f o I n t e g e r ( s y m b o l ,   S Y M B O L _ T R A D E _ F R E E Z E _ L E V E L ) ;  
  
 	 	 i f   ( O r d e r T y p e ( )   <   2 )   { o p   =   O r d e r O p e n P r i c e ( ) ; }   e l s e   { o p   =   N o r m a l i z e D o u b l e ( o p , d i g i t s ) ; }  
  
 	 	 s l l   =   N o r m a l i z e D o u b l e ( s l l ,   d i g i t s ) ;  
 	 	 t p l   =   N o r m a l i z e D o u b l e ( t p l ,   d i g i t s ) ;  
  
 	 	 i f   ( o p   <   0   | |   o p   > =   E M P T Y _ V A L U E   | |   s l l   <   0   | |   s l p   <   0   | |   t p l   <   0   | |   t p p   <   0 )  
 	 	 {  
 	 	 	 b r e a k ;  
 	 	 }  
 	 	  
 	 	 / / - -   O P   - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  
 	 	 / /   h t t p s : / / b o o k . m q l 4 . c o m / a p p e n d i x / l i m i t s  
 	 	 i f   ( t y p e   = =   O P _ B U Y L I M I T )  
 	 	 {  
 	 	 	 i f   ( a s k   -   o p   <   s t o p l e v e l )   { o p   =   a s k   -   s t o p l e v e l ; }  
 	 	 	 i f   ( a s k   -   o p   < =   f r e e z e l e v e l )   { o p   =   a s k   -   f r e e z e l e v e l   -   p o i n t ; }  
 	 	 }  
 	 	 e l s e   i f   ( t y p e   = =   O P _ B U Y S T O P )  
 	 	 {  
 	 	 	 i f   ( o p   -   a s k   <   s t o p l e v e l )   { o p   =   a s k   +   s t o p l e v e l ; }  
 	 	 	 i f   ( o p   -   a s k   < =   f r e e z e l e v e l )   { o p   =   a s k   +   f r e e z e l e v e l   +   p o i n t ; }  
 	 	 }  
 	 	 e l s e   i f   ( t y p e   = =   O P _ S E L L L I M I T )  
 	 	 {  
 	 	 	 i f   ( o p   -   b i d   <   s t o p l e v e l )   { o p   =   b i d   +   s t o p l e v e l ; }  
 	 	 	 i f   ( o p   -   b i d   < =   f r e e z e l e v e l )   { o p   =   b i d   +   f r e e z e l e v e l   +   p o i n t ; }  
 	 	 }  
 	 	 e l s e   i f   ( t y p e   = =   O P _ S E L L S T O P )  
 	 	 {  
 	 	 	 i f   ( b i d   -   o p   <   s t o p l e v e l )   { o p   =   b i d   -   s t o p l e v e l ; }  
 	 	 	 i f   ( b i d   -   o p   <   f r e e z e l e v e l )   { o p   =   b i d   -   f r e e z e l e v e l   -   p o i n t ; }  
 	 	 }  
  
 	 	 o p   =   N o r m a l i z e D o u b l e ( o p ,   d i g i t s ) ;  
  
 	 	 / / - -   S L   a n d   T P   - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  
 	 	 d o u b l e   s l   =   0 ,   t p   =   0 ,   v s l   =   0 ,   v t p   =   0 ;  
  
 	 	 s l   =   A l i g n S t o p L o s s ( s y m b o l ,   t y p e ,   o p ,   a t t r S t o p L o s s ( ) ,   s l l ,   s l p ) ;  
  
 	 	 i f   ( s l   <   0 )   { b r e a k ; }  
  
 	 	 t p   =   A l i g n T a k e P r o f i t ( s y m b o l ,   t y p e ,   o p ,   a t t r T a k e P r o f i t ( ) ,   t p l ,   t p p ) ;  
  
 	 	 i f   ( t p   <   0 )   { b r e a k ; }  
  
 	 	 i f   ( U S E _ V I R T U A L _ S T O P S )  
 	 	 {  
 	 	 	 / / - -   v i r t u a l   S L   a n d   T P   - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  
 	 	 	 v s l   =   s l ;  
 	 	 	 v t p   =   t p ;  
 	 	 	 s l   =   0 ;  
 	 	 	 t p   =   0 ;  
  
 	 	 	 d o u b l e   a s k b i d   =   a s k ;  
 	 	 	 i f   ( b s   <   0 )   { a s k b i d   =   b i d ; }  
  
 	 	 	 i f   ( v s l   >   0   | |   U S E _ E M E R G E N C Y _ S T O P S   = =   " a l w a y s " )  
 	 	 	 {  
 	 	 	 	 i f   ( E M E R G E N C Y _ S T O P S _ R E L   >   0   | |   E M E R G E N C Y _ S T O P S _ A D D   >   0 )  
 	 	 	 	 {  
 	 	 	 	 	 s l   =   v s l   -   E M E R G E N C Y _ S T O P S _ R E L * M a t h A b s ( a s k b i d - v s l ) * b s ;  
  
 	 	 	 	 	 i f   ( s l   < =   0 )   { s l   =   a s k b i d ; }  
  
 	 	 	 	 	 s l   =   s l   -   t o D i g i t s ( E M E R G E N C Y _ S T O P S _ A D D , s y m b o l ) * b s ;  
 	 	 	 	 }  
 	 	 	 }  
  
 	 	 	 i f   ( v t p   >   0   | |   U S E _ E M E R G E N C Y _ S T O P S   = =   " a l w a y s " )  
 	 	 	 {  
 	 	 	 	 i f   ( E M E R G E N C Y _ S T O P S _ R E L   >   0   | |   E M E R G E N C Y _ S T O P S _ A D D   >   0 )  
 	 	 	 	 {  
 	 	 	 	 	 t p   =   v t p   +   E M E R G E N C Y _ S T O P S _ R E L * M a t h A b s ( v t p - a s k b i d ) * b s ;  
  
 	 	 	 	 	 i f   ( t p   < =   0 )   { t p   =   a s k b i d ; }  
  
 	 	 	 	 	 t p   =   t p   +   t o D i g i t s ( E M E R G E N C Y _ S T O P S _ A D D , s y m b o l ) * b s ;  
 	 	 	 	 }  
 	 	 	 }  
  
 	 	 	 v s l   =   N o r m a l i z e D o u b l e ( v s l , d i g i t s ) ;  
 	 	 	 v t p   =   N o r m a l i z e D o u b l e ( v t p , d i g i t s ) ;  
 	 	 }  
  
 	 	 s l   =   N o r m a l i z e D o u b l e ( s l , d i g i t s ) ;  
 	 	 t p   =   N o r m a l i z e D o u b l e ( t p , d i g i t s ) ;  
  
 	 	 / / - -   m o d i f y   - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  
 	 	 R e s e t L a s t E r r o r ( ) ;  
 	 	  
 	 	 i f   ( U S E _ V I R T U A L _ S T O P S )  
 	 	 {  
 	 	 	 i f   ( v s l   ! =   a t t r S t o p L o s s ( )   | |   v t p   ! =   a t t r T a k e P r o f i t ( ) )  
 	 	 	 {  
 	 	 	 	 V i r t u a l S t o p s D r i v e r ( " s e t " ,   t i c k e t ,   v s l ,   v t p ,   t o P i p s ( M a t h A b s ( o p - v s l ) ,   s y m b o l ) ,   t o P i p s ( M a t h A b s ( v t p - o p ) ,   s y m b o l ) ) ;  
 	 	 	 }  
 	 	 }  
  
 	 	 b o o l   s u c c e s s   =   f a l s e ;  
  
 	 	 i f   (  
 	 	 	       ( O r d e r T y p e ( )   >   1   & &   o p   ! =   N o r m a l i z e D o u b l e ( O r d e r O p e n P r i c e ( ) , d i g i t s ) )  
 	 	 	 | |   s l   ! =   N o r m a l i z e D o u b l e ( O r d e r S t o p L o s s ( ) , d i g i t s )  
 	 	 	 | |   t p   ! =   N o r m a l i z e D o u b l e ( O r d e r T a k e P r o f i t ( ) , d i g i t s )  
 	 	 	 | |   e x p   ! =   O r d e r E x p i r a t i o n ( )  
 	 	 )   {  
 	 	 	 s u c c e s s   =   O r d e r M o d i f y ( t i c k e t ,   o p ,   s l ,   t p ,   e x p ,   c l r ) ;  
 	 	 }  
  
 	 	 / / - -   e r r o r   c h e c k   - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  
 	 	 i n t   e r r a c t i o n   =   C h e c k F o r T r a d i n g E r r o r ( G e t L a s t E r r o r ( ) ,   " M o d i f y   e r r o r " ) ;  
  
 	 	 s w i t c h ( e r r a c t i o n )  
 	 	 {  
 	 	 	 c a s e   0 :   b r e a k ;         / /   n o   e r r o r  
 	 	 	 c a s e   1 :   c o n t i n u e ;   / /   o v e r c o m a b l e   e r r o r  
 	 	 	 c a s e   2 :   b r e a k ;         / /   f a t a l   e r r o r  
 	 	 }  
  
 	 	 / / - -   f i n i s h   w o r k   - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  
 	 	 i f   ( s u c c e s s   = =   t r u e )  
 	 	 {  
 	 	 	 i f   ( ! I s T e s t i n g ( )   & &   ! I s V i s u a l M o d e ( ) )  
 	 	 	 {  
 	 	 	 	 P r i n t ( " O p e r a t i o n   d e t a i l s :   S p e e d   "   +   ( s t r i n g ) ( G e t T i c k C o u n t ( ) - t i m e 0 )   +   "   m s " ) ;  
 	 	 	 }  
  
 	 	 	 i f   ( o n t r a d e _ e v e n t   = =   t r u e )  
 	 	 	 {  
 	 	 	 	 O r d e r M o d i f i e d ( t i c k e t ) ;  
 	 	 	 	 R e g i s t e r E v e n t ( " t r a d e " ) ;  
 	 	 	 }  
  
 	 	 	 i f   ( O r d e r S e l e c t ( t i c k e t , S E L E C T _ B Y _ T I C K E T ) )   { }  
  
 	 	 	 r e t u r n   t r u e ;  
 	 	 }  
  
 	 	 b r e a k ;  
 	 }  
  
 	 r e t u r n   f a l s e ;  
 }  
  
 i n t   O C O D r i v e r ( )  
 {  
 	 s t a t i c   i n t   l a s t _ k n o w n _ t i c k e t   =   0 ;  
       s t a t i c   i n t   o r d e r s 1 [ ] ;  
       s t a t i c   i n t   o r d e r s 2 [ ] ;  
       i n t   i ,   s i z e ;  
        
       i n t   t o t a l   =   O r d e r s T o t a l ( ) ;  
        
       f o r   ( i n t   p o s = t o t a l - 1 ;   p o s > = 0 ;   p o s - - )  
       {  
             i f   ( O r d e r S e l e c t ( p o s , S E L E C T _ B Y _ P O S , M O D E _ T R A D E S ) )  
             {  
                   i n t   t i c k e t   =   O r d e r T i c k e t ( ) ;  
                    
                   / / - -   e n d   h e r e   i f   w e   r e a c h   t h e   l a s t   k n o w n   t i c k e t  
                   i f   ( t i c k e t   = =   l a s t _ k n o w n _ t i c k e t )   { b r e a k ; }  
                    
                   / / - -   s e t   t h e   l a s t   k n o w n   t i c k e t ,   o n l y   i f   t h i s   i s   t h e   f i r s t   i t e r a t i o n  
                   i f   ( p o s   = =   t o t a l - 1 )   {  
                         l a s t _ k n o w n _ t i c k e t   =   t i c k e t ;  
                   }  
                    
                   / / - -   w e   a r e   s e a r c h i n g   f o r   p e n d i n g   o r d e r s ,   s k i p   t r a d e s  
                   i f   ( O r d e r T y p e ( )   < =   O P _ S E L L )   { c o n t i n u e ; }  
                    
                   / / - -  
                   i f   ( S t r i n g S u b s t r ( O r d e r C o m m e n t ( ) ,   0 ,   5 )   = =   " [ o c o : " )  
                   {  
                         i n t   t i c k e t _ o c o   =   S t r T o I n t e g e r ( S t r i n g S u b s t r ( O r d e r C o m m e n t ( ) ,   5 ,   S t r i n g L e n ( O r d e r C o m m e n t ( ) ) - 1 ) ) ;    
                          
                         b o o l   f o u n d   =   f a l s e ;  
                         s i z e   =   A r r a y S i z e ( o r d e r s 2 ) ;  
                         f o r   ( i = 0 ;   i < s i z e ;   i + + )  
                         {  
                               i f   ( o r d e r s 2 [ i ]   = =   t i c k e t _ o c o )   {  
                                     f o u n d   =   t r u e ;  
                                     b r e a k ;  
                               }  
                         }  
                          
                         i f   ( f o u n d   = =   f a l s e )   {  
                               A r r a y R e s i z e ( o r d e r s 1 ,   s i z e + 1 ) ;  
                               A r r a y R e s i z e ( o r d e r s 2 ,   s i z e + 1 ) ;  
                               o r d e r s 1 [ s i z e ]   =   t i c k e t _ o c o ;  
                               o r d e r s 2 [ s i z e ]   =   t i c k e t ;  
                         }  
                   }  
             }  
       }  
        
       s i z e   =   A r r a y S i z e ( o r d e r s 1 ) ;  
       i n t   d b r e m o v e   =   f a l s e ;  
       f o r   ( i = s i z e - 1 ;   i > = 0 ;   i - - )  
       {  
             i f   ( O r d e r S e l e c t ( o r d e r s 1 [ i ] ,   S E L E C T _ B Y _ T I C K E T ,   M O D E _ T R A D E S )   = =   f a l s e   | |   O r d e r T y p e ( )   < =   O P _ S E L L )  
             {  
                   i f   ( O r d e r S e l e c t ( o r d e r s 2 [ i ] ,   S E L E C T _ B Y _ T I C K E T ,   M O D E _ T R A D E S ) )   {  
                         i f   ( D e l e t e O r d e r ( o r d e r s 2 [ i ] , c l r W h i t e ) )  
                         {  
                               d b r e m o v e   =   t r u e ;  
                         }  
                   }  
                   e l s e   {  
                         d b r e m o v e   =   t r u e ;  
                   }  
                    
                   i f   ( d b r e m o v e   = =   t r u e )  
                   {  
                         A r r a y S t r i p K e y ( o r d e r s 1 ,   i ) ;  
                         A r r a y S t r i p K e y ( o r d e r s 2 ,   i ) ;  
                   }  
             }  
       }  
        
       s i z e   =   A r r a y S i z e ( o r d e r s 2 ) ;  
       d b r e m o v e   =   f a l s e ;  
       f o r   ( i = s i z e - 1 ;   i > = 0 ;   i - - )  
       {  
             i f   ( O r d e r S e l e c t ( o r d e r s 2 [ i ] ,   S E L E C T _ B Y _ T I C K E T ,   M O D E _ T R A D E S )   = =   f a l s e   | |   O r d e r T y p e ( )   < =   O P _ S E L L )  
             {  
                   i f   ( O r d e r S e l e c t ( o r d e r s 1 [ i ] ,   S E L E C T _ B Y _ T I C K E T ,   M O D E _ T R A D E S ) )   {  
                         i f   ( D e l e t e O r d e r ( o r d e r s 1 [ i ] , c l r W h i t e ) )  
                         {  
                               d b r e m o v e   =   t r u e ;  
                         }  
                   }  
                   e l s e   {  
                         d b r e m o v e   =   t r u e ;  
                   }  
                    
                   i f   ( d b r e m o v e   = =   t r u e )  
                   {  
                         A r r a y S t r i p K e y ( o r d e r s 1 ,   i ) ;  
                         A r r a y S t r i p K e y ( o r d e r s 2 ,   i ) ;  
                   }  
             }  
       }  
        
       r e t u r n   t r u e ;  
 }  
  
 b o o l   O n T i m e r S e t ( d o u b l e   s e c o n d s )  
 {  
       i f   ( F X D _ O N T I M E R _ T A K E N )  
       {  
             i f   ( s e c o n d s < = 0 )   {  
                   F X D _ O N T I M E R _ T A K E N _ I N _ M I L L I S E C O N D S   =   f a l s e ;  
                   F X D _ O N T I M E R _ T A K E N _ T I M E   =   0 ;  
             }  
             e l s e   i f   ( s e c o n d s   <   1 )   {  
                   F X D _ O N T I M E R _ T A K E N _ I N _ M I L L I S E C O N D S   =   t r u e ;  
                   F X D _ O N T I M E R _ T A K E N _ T I M E   =   s e c o n d s * 1 0 0 0 ;    
             }  
             e l s e   {  
                   F X D _ O N T I M E R _ T A K E N _ I N _ M I L L I S E C O N D S   =   f a l s e ;  
                   F X D _ O N T I M E R _ T A K E N _ T I M E   =   s e c o n d s ;  
             }  
              
             r e t u r n   t r u e ;  
       }  
  
       i f   ( s e c o n d s < = 0 )   {  
             E v e n t K i l l T i m e r ( ) ;  
       }  
       e l s e   i f   ( s e c o n d s   <   1 )   {  
             r e t u r n   ( E v e n t S e t M i l l i s e c o n d T i m e r ( ( i n t ) ( s e c o n d s * 1 0 0 0 ) ) ) ;      
       }  
       e l s e   {  
             r e t u r n   ( E v e n t S e t T i m e r ( ( i n t ) s e c o n d s ) ) ;  
       }  
        
       r e t u r n   t r u e ;  
 }  
  
 v o i d   O n T r a d e L i s t e n e r ( )  
 {  
 	 s t a t i c   d a t e t i m e   s t a r t _ t i m e   =   - 1 ;  
 	 s t a t i c   i n t         m e m o r y _ t i [ ] ;   / /   m e m o r y   o f   t i c k e t s  
 	 s t a t i c   i n t         m e m o r y _ t y [ ] ;   / /   m e m o r y   o f   t y p e s  
 	 s t a t i c   d o u b l e   m e m o r y _ s l [ ] ;  
 	 s t a t i c   d o u b l e   m e m o r y _ t p [ ] ;  
 	 s t a t i c   d o u b l e   m e m o r y _ v l [ ] ;  
 	 s t a t i c   d o u b l e   m e m o r y _ o p [ ] ;  
 	 s t a t i c   b o o l   l o a d e d   =   f a l s e ;  
  
 	 i f   ( ! E N A B L E _ E V E N T _ T R A D E )   { r e t u r n ; }  
  
 	 i n t   t n                     =   0 ;     / /   t i c k e t   n o w   ( i n d e x )  
 	 i n t   t i                     =   - 1 ;   / /   t i c k e t  
 	 i n t   t y                     =   - 1 ;   / /   t y p e  
 	 i n t   s i z e                 =   - 1 ;  
 	 i n t   p o s                   =   0 ;  
 	 s t r i n g   e _ r e a s o n   =   " " ;  
 	 s t r i n g   e _ d e t a i l   =   " " ;  
 	 i n t   i   =   - 1 ,   j   =   - 1 ,   k   =   - 1 ;  
 	 i n t   t i c k e t s _ n o w [ ] ;  
 	  
  
 	 i f   ( s t a r t _ t i m e   = =   - 1 )   { s t a r t _ t i m e   =   T i m e C u r r e n t ( ) ; }  
  
 	 / / - -   T R A D E S   A N D   O R D E R S  
 	 A r r a y R e s i z e ( t i c k e t s _ n o w ,   0 ) ;  
  
 	 i n t   t o t a l   =   O r d e r s T o t a l ( ) ;  
  
 	 / /   i n i t i a l   f i l l   o f   t h e   l o c a l   D B  
 	 i f   ( l o a d e d   = =   f a l s e )  
 	 {  
 	 	 l o a d e d   =   t r u e ;  
  
 	 	 f o r   ( p o s   =   t o t a l - 1 ;   p o s   > =   0 ;   p o s - - )  
 	 	 {  
 	 	 	 i f   ( O r d e r S e l e c t ( p o s ,   S E L E C T _ B Y _ P O S ,   M O D E _ T R A D E S ) )  
 	 	 	 {  
 	 	 	 	 A r r a y R e s i z e ( m e m o r y _ t i ,   t n + 1 ) ;  
 	 	 	 	 A r r a y R e s i z e ( m e m o r y _ t y ,   t n + 1 ) ;  
 	 	 	 	 A r r a y R e s i z e ( m e m o r y _ s l ,   t n + 1 ) ;  
 	 	 	 	 A r r a y R e s i z e ( m e m o r y _ t p ,   t n + 1 ) ;  
 	 	 	 	 A r r a y R e s i z e ( m e m o r y _ v l ,   t n + 1 ) ;  
 	 	 	 	 A r r a y R e s i z e ( m e m o r y _ o p ,   t n + 1 ) ;  
 	 	 	 	 m e m o r y _ t i [ t n ]   =   O r d e r T i c k e t ( ) ;  
 	 	 	 	 m e m o r y _ t y [ t n ]   =   O r d e r T y p e ( ) ;  
 	 	 	 	 m e m o r y _ s l [ t n ]   =   a t t r S t o p L o s s ( ) ;  
 	 	 	 	 m e m o r y _ t p [ t n ]   =   a t t r T a k e P r o f i t ( ) ;  
 	 	 	 	 m e m o r y _ v l [ t n ]   =   O r d e r L o t s ( ) ;  
 	 	 	 	 m e m o r y _ o p [ t n ]   =   O r d e r O p e n P r i c e ( ) ;  
  
 	 	 	 	 t n + + ;  
 	 	 	 }  
 	 	 }  
  
 	 	 r e t u r n ;  
 	 }  
  
 	 t n   =   0 ;  
  
 	 b o o l   p e n d i n g _ o p e n s   =   f a l s e ;  
  
 	 f o r   ( p o s   =   t o t a l - 1 ;   p o s   > =   0 ;   p o s - - )  
 	 {  
 	 	 i f   ( O r d e r S e l e c t ( p o s ,   S E L E C T _ B Y _ P O S ,   M O D E _ T R A D E S ) )  
 	 	 {  
 	 	 	 A r r a y R e s i z e ( t i c k e t s _ n o w ,   t n + 1 ) ;  
 	 	 	 t i c k e t s _ n o w [ t n ]   =   O r d e r T i c k e t ( ) ;  
 	 	 	 t n + + ;  
  
 	 	 	 / /   T r a d e s   a n d   O r d e r s  
 	 	 	 i         =   - 1 ;  
 	 	 	 t i       =   - 1 ;  
 	 	 	 t y       =   - 1 ;  
 	 	 	 s i z e   =   A r r a y S i z e ( m e m o r y _ t i ) ;  
  
 	 	 	 i f   ( s i z e   >   0 )  
 	 	 	 {  
 	 	 	 	 f o r   ( i   =   0 ;   i   <   s i z e ;   i + + )  
 	 	 	 	 {  
 	 	 	 	 	 i f   ( m e m o r y _ t i [ i ]   = =   O r d e r T i c k e t ( ) )  
 	 	 	 	 	 {  
 	 	 	 	 	 	 i f   ( m e m o r y _ t y [ i ]   = =   O r d e r T y p e ( ) )  
 	 	 	 	 	 	 {  
 	 	 	 	 	 	 	 t y   =   O r d e r T y p e ( ) ;  
 	 	 	 	 	 	 }  
 	 	 	 	 	 	 e l s e  
 	 	 	 	 	 	 {  
 	 	 	 	 	 	 	 p e n d i n g _ o p e n s   =   t r u e ;  
 	 	 	 	 	 	 }  
  
 	 	 	 	 	 	 t i   =   O r d e r T i c k e t ( ) ;  
  
 	 	 	 	 	 	 b r e a k ;  
 	 	 	 	     }  
 	 	 	     }  
 	 	 	 }  
  
 	 	 	 / /   O r d e r   b e c o m e   a   t r a d e  
 	 	 	 i f   ( t i   >   0   & &   t y   <   0 )  
 	 	 	 {  
 	 	 	 	 m e m o r y _ t i [ i ]   =   O r d e r T i c k e t ( ) ;  
 	 	 	 	 m e m o r y _ t y [ i ]   =   O r d e r T y p e ( ) ;  
  
 	 	 	 	 m e m o r y _ s l [ i ]   =   a t t r S t o p L o s s ( ) ;  
 	 	 	 	 m e m o r y _ t p [ i ]   =   a t t r T a k e P r o f i t ( ) ;  
 	 	 	 	 m e m o r y _ v l [ i ]   =   O r d e r L o t s ( ) ;  
 	 	 	 	 m e m o r y _ o p [ i ]   =   O r d e r O p e n P r i c e ( ) ;  
  
 	 	 	 	 e _ r e a s o n   =   " n e w " ;  
 	 	 	 	 e _ d e t a i l   =   " " ;  
  
 	 	 	 	 b r e a k ;  
 	 	 	 }  
  
 	 	 	 / /   N e w   t r a d e / o r d e r   o p e n e d  
 	 	 	 e l s e   i f   ( t i   <   0   & &   t y   <   0 )  
 	 	 	 {  
 	 	 	 	 A r r a y R e s i z e ( m e m o r y _ t i ,   s i z e + 1 ) ;   m e m o r y _ t i [ s i z e ]   =   O r d e r T i c k e t ( ) ;  
 	 	 	 	 A r r a y R e s i z e ( m e m o r y _ t y ,   s i z e + 1 ) ;   m e m o r y _ t y [ s i z e ]   =   O r d e r T y p e ( ) ;  
 	 	 	 	 A r r a y R e s i z e ( m e m o r y _ s l ,   s i z e + 1 ) ;   m e m o r y _ s l [ s i z e ]   =   a t t r S t o p L o s s ( ) ;  
 	 	 	 	 A r r a y R e s i z e ( m e m o r y _ t p ,   s i z e + 1 ) ;   m e m o r y _ t p [ s i z e ]   =   a t t r T a k e P r o f i t ( ) ;  
 	 	 	 	 A r r a y R e s i z e ( m e m o r y _ v l ,   s i z e + 1 ) ;   m e m o r y _ v l [ s i z e ]   =   O r d e r L o t s ( ) ;  
 	 	 	 	 A r r a y R e s i z e ( m e m o r y _ o p ,   s i z e + 1 ) ;   m e m o r y _ o p [ s i z e ]   =   O r d e r O p e n P r i c e ( ) ;  
  
 	 	 	 	 e _ r e a s o n   =   " n e w " ;  
 	 	 	 	 e _ d e t a i l   =   " " ;  
  
 	 	 	 	 b r e a k ;  
 	 	 	 }  
  
 	 	 	 / /   C h e c k   f o r   L o t s ,   S L   o r   T P   m o d i f i c a t i o n  
 	 	 	 e l s e   i f   ( t y   > =   0   & &   i   >   - 1 )  
 	 	 	 {  
 	 	 	 	 i f   ( m e m o r y _ v l [ i ]   ! =   O r d e r L o t s ( ) )  
 	 	 	 	 {  
 	 	 	 	 	 m e m o r y _ v l [ i ]   =   O r d e r L o t s ( ) ;  
 	 	 	 	 	 e _ r e a s o n   =   " m o d i f y " ;  
 	 	 	 	 	 e _ d e t a i l   =   " l o t s " ;  
  
 	 	 	 	 	 b r e a k ;  
 	 	 	 	 }  
 	 	 	 	 e l s e   i f   ( m e m o r y _ o p [ i ]   ! =   O r d e r O p e n P r i c e ( ) )  
 	 	 	 	 {  
 	 	 	 	 	 m e m o r y _ o p [ i ]   =   O r d e r O p e n P r i c e ( ) ;  
 	 	 	 	 	 m e m o r y _ s l [ i ]   =   a t t r S t o p L o s s ( ) ;  
 	 	 	 	 	 m e m o r y _ t p [ i ]   =   a t t r T a k e P r o f i t ( ) ;  
 	 	 	 	 	 e _ r e a s o n   =   " m o d i f y " ;  
 	 	 	 	 	 e _ d e t a i l   =   " m o v e " ;  
  
 	 	 	 	 	 b r e a k ;  
 	 	 	 	 }  
 	 	 	 	 e l s e  
 	 	 	 	 {  
 	 	 	 	 	 i f   ( m e m o r y _ s l [ i ]   ! =   a t t r S t o p L o s s ( )   & &   m e m o r y _ t p [ i ]   ! =   a t t r T a k e P r o f i t ( ) )  
 	 	 	 	 	 {  
 	 	 	 	 	 	 m e m o r y _ s l [ i ]   =   a t t r S t o p L o s s ( ) ;  
 	 	 	 	 	 	 m e m o r y _ t p [ i ]   =   a t t r T a k e P r o f i t ( ) ;  
 	 	 	 	 	 	 e _ r e a s o n   =   " m o d i f y " ;  
 	 	 	 	 	 	 e _ d e t a i l   =   " s l t p " ;  
  
 	 	 	 	 	 	 b r e a k ;  
 	 	 	 	 	 }  
 	 	 	 	 	 e l s e   i f   ( m e m o r y _ s l [ i ]   ! =   a t t r S t o p L o s s ( ) )  
 	 	 	 	 	 {  
 	 	 	 	 	 	 m e m o r y _ s l [ i ]   =   a t t r S t o p L o s s ( ) ;  
 	 	 	 	 	 	 e _ r e a s o n   =   " m o d i f y " ;  
 	 	 	 	 	 	 e _ d e t a i l   =   " s l " ;  
  
 	 	 	 	 	 	 b r e a k ;  
 	 	 	 	 	 }  
 	 	 	 	     	 e l s e   i f   ( m e m o r y _ t p [ i ]   ! =   a t t r T a k e P r o f i t ( ) )  
 	 	 	 	     	 {  
 	 	 	 	     	 	 m e m o r y _ t p [ i ]   =   a t t r T a k e P r o f i t ( ) ;  
 	 	 	 	     	 	 e _ r e a s o n   =   " m o d i f y " ;  
 	 	 	 	     	 	 e _ d e t a i l   =   " t p " ;  
  
 	 	 	 	 	 	 b r e a k ;  
 	 	 	 	     	 }  
 	 	 	 	 }  
 	 	 	 }  
 	 	 }  
 	 }  
  
 	 / /   C h e c k   f o r   c l o s e d   o r d e r s / t r a d e s  
 	 b o o l   m i s s i n g   =   t r u e ;  
  
 	 i f   (  
 	 	       e _ r e a s o n   = =   " "  
 	 	 & &   p e n d i n g _ o p e n s   = =   f a l s e  
 	 	 & &   A r r a y S i z e ( t i c k e t s _ n o w )   <   A r r a y S i z e ( m e m o r y _ t i )  
 	 )  
 	 {  
 	 	 / /   f o r   e a c h   t i c k e t   i n   t h e   m e m o r y   c h e c k   i f   t r a d e   e x i s t s   n o w  
 	 	 f o r ( i   =   A r r a y S i z e ( m e m o r y _ t i ) - 1 ;   i   > =   0 ;   i - - )  
 	 	 {  
 	 	 	 f o r ( j   =   0 ;   j   <   A r r a y S i z e ( t i c k e t s _ n o w ) ;   j + + )  
 	 	 	 {  
 	 	 	 	 i f   ( m e m o r y _ t i [ i ]   = =   t i c k e t s _ n o w [ j ] )  
 	 	 	 	 {  
 	 	 	 	 	 m i s s i n g   =   f a l s e ;  
  
 	 	 	 	 	 b r e a k ;  
 	 	 	 	 }  
 	 	 	 }  
  
 	 	 	 i f   ( m i s s i n g   = =   t r u e )  
 	 	 	 {  
 	 	 	 	 i f   ( O r d e r S e l e c t ( m e m o r y _ t i [ i ] ,   S E L E C T _ B Y _ T I C K E T ) )  
 	 	 	 	 {  
 	 	 	 	 	 / /   T h i s   c a n   h a p p e n   m o r e   t h a n   o n c e  
 	 	 	 	 	 A r r a y S t r i p K e y ( m e m o r y _ t i ,   i ) ;  
 	 	 	 	 	 A r r a y S t r i p K e y ( m e m o r y _ t y ,   i ) ;  
 	 	 	 	 	 A r r a y S t r i p K e y ( m e m o r y _ s l ,   i ) ;  
 	 	 	 	 	 A r r a y S t r i p K e y ( m e m o r y _ t p ,   i ) ;  
 	 	 	 	 	 A r r a y S t r i p K e y ( m e m o r y _ v l ,   i ) ;  
 	 	 	 	 	 A r r a y S t r i p K e y ( m e m o r y _ o p ,   i ) ;  
  
 	 	 	 	 	 e _ r e a s o n   =   " c l o s e " ;  
 	 	 	 	 	 e _ d e t a i l   =   " " ;  
 	 	 	 	 	  
 	 	 	 	 	 i f   (  
 	 	 	 	 	 	       S t r i n g F i n d ( O r d e r C o m m e n t ( ) ,   " e x p i r a t i o n " )   > =   0  
 	 	 	 	 	 	 | |   S t r i n g F i n d ( O r d e r C o m m e n t ( ) ,   " [ e x p : " )   > =   0  
 	 	 	 	 	 )  
 	 	 	 	 	 {  
 	 	 	 	 	 	 e _ d e t a i l   =   " e x p i r e " ;  
 	 	 	 	 	 }  
  
 	 	 	 	 	 / /   r e m o v e   v i r t u a l   s t o p s   l i n e s  
 	 	 	 	 	 i f   ( U S E _ V I R T U A L _ S T O P S )  
 	 	 	 	 	 {  
 	 	 	 	 	 	 O b j e c t D e l e t e ( " # "   +   ( s t r i n g ) O r d e r T i c k e t ( )   +   "   s l " ) ;  
 	 	 	 	 	 	 O b j e c t D e l e t e ( " # "   +   ( s t r i n g ) O r d e r T i c k e t ( )   +   "   t p " ) ;  
 	 	 	 	 	 }  
  
 	 	 	 	 	 b r e a k ;  
 	 	 	 	 }  
 	 	 	 }  
  
 	 	 	 m i s s i n g   =   t r u e ;  
 	 	 }  
 	 }  
  
 	 i f   ( e _ r e a s o n   ! =   " " )  
 	 {  
 	 	 U p d a t e E v e n t V a l u e s ( e _ r e a s o n ,   e _ d e t a i l ) ;  
 	 	 E v e n t T r a d e ( ) ;  
 	 	 O n T r a d e L i s t e n e r ( ) ;  
 	 }  
 	  
 	 r e t u r n ;  
 }  
  
 i n t   O n T r a d e Q u e u e ( i n t   q u e u e = 0 )  
 {  
       s t a t i c   i n t   m e m = 0 ;  
       m e m = m e m + q u e u e ;  
       r e t u r n ( m e m ) ;  
 }  
  
 i n t   O r d e r C r e a t e (  
 	 s t r i n g       s y m b o l           =   " " ,  
 	 i n t             t y p e               =   O P _ B U Y ,  
 	 d o u b l e       l o t s               =   0 ,  
 	 d o u b l e       o p                   =   0 ,  
 	 d o u b l e       s l l                 =   0 ,   / /   S L   l e v e l  
 	 d o u b l e       t p l                 =   0 ,   / /   T O   l e v e l  
 	 d o u b l e       s l p                 =   0 ,   / /   S L   a d j u s t   i n   p o i n t s  
 	 d o u b l e       t p p                 =   0 ,   / /   T P   a d j u s t   i n   p o i n t s  
 	 d o u b l e       s l i p p a g e       =   0 ,  
 	 i n t             m a g i c             =   0 ,  
 	 s t r i n g       c o m m e n t         =   " " ,  
 	 c o l o r         a r r o w c o l o r   =   C L R _ N O N E ,  
 	 d a t e t i m e   e x p i r a t i o n   =   0 ,  
 	 b o o l           o c o                 =   f a l s e  
 	 )  
 {  
 	 u i n t   t i m e 0   =   G e t T i c k C o u n t ( ) ;   / /   u s e d   t o   m e a s u r e   s p e e d   o f   e x e c u t i o n   o f   t h e   o r d e r  
  
 	 i n t   t i c k e t   =   - 1 ;  
 	  
 	 / /   c a l c u l a t e   b u y / s e l l   f l a g   ( 1   w h e n   B u y   o r   - 1   w h e n   S e l l )  
 	 i n t   b s   =   1 ;  
  
 	 i f   (  
 	 	       t y p e   = =   O P _ S E L L  
 	 	 | |   t y p e   = =   O P _ S E L L S T O P  
 	 	 | |   t y p e   = =   O P _ S E L L L I M I T  
 	 	 )  
 	 {  
 	 	 b s   =   - 1 ;  
 	 }  
  
 	 i f   ( s y m b o l   = =   " " )   { s y m b o l   =   S y m b o l ( ) ; }  
  
 	 l o t s   =   A l i g n L o t s ( s y m b o l ,   l o t s ) ;  
  
 	 i n t   d i g i t s   =   0 ;  
 	 d o u b l e   a s k   =   0 ,   b i d   =   0 ,   p o i n t   =   0 ,   t i c k s i z e   =   0 ;  
 	 d o u b l e   s l   =   0 ,   t p   =   0 ;  
 	 d o u b l e   v s l   =   0 ,   v t p   =   0 ;  
  
 	 / / - -   a t t e m p t   t o   s e n d   t r a d e / o r d e r   - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  
 	 w h i l e   ( ! I s S t o p p e d ( ) )  
 	 {  
 	 	 W a i t T r a d e C o n t e x t I f B u s y ( ) ;  
  
 	 	 s t a t i c   b o o l   n o t _ a l l o w e d _ m e s s a g e   =   f a l s e ;  
  
 	 	 i f   (  
 	 	 	       ! M Q L I n f o I n t e g e r ( M Q L _ T E S T E R )  
 	 	 	 & &   ! M a r k e t I n f o ( s y m b o l ,   M O D E _ T R A D E A L L O W E D )  
 	 	 )   {  
 	 	 	 i f   ( n o t _ a l l o w e d _ m e s s a g e   = =   f a l s e )  
 	 	 	 {  
 	 	 	 	 P r i n t ( " M a r k e t   ( " + s y m b o l + " )   i s   c l o s e d " ) ;  
 	 	 	 }  
  
 	 	 	 n o t _ a l l o w e d _ m e s s a g e   =   t r u e ;  
  
 	 	 	 r e t u r n   f a l s e ;  
 	 	 }  
  
 	 	 n o t _ a l l o w e d _ m e s s a g e   =   f a l s e ;  
 	 	  
 	 	 d i g i t s       =   ( i n t ) M a r k e t I n f o ( s y m b o l ,   M O D E _ D I G I T S ) ;  
 	 	 a s k             =   M a r k e t I n f o ( s y m b o l ,   M O D E _ A S K ) ;  
 	 	 b i d             =   M a r k e t I n f o ( s y m b o l ,   M O D E _ B I D ) ;  
 	 	 p o i n t         =   M a r k e t I n f o ( s y m b o l ,   M O D E _ P O I N T ) ;  
 	 	 t i c k s i z e   =   M a r k e t I n f o ( s y m b o l ,   M O D E _ T I C K S I Z E ) ;  
 	 	  
 	 	 / / -   n o t   e n o u g h   m o n e y   c h e c k :   f i x   m a x i m u m   p o s s i b l e   l o t   b y   m a r g i n   r e q u i r e d ,   o r   q u i t  
 	 	 i f   ( t y p e = = O P _ B U Y   | |   t y p e = = O P _ S E L L )  
 	 	 {  
 	 	 	 d o u b l e   L o t S t e p                     =   M a r k e t I n f o ( s y m b o l , M O D E _ L O T S T E P ) ;  
 	 	 	 d o u b l e   M i n L o t s                     =   M a r k e t I n f o ( s y m b o l , M O D E _ M I N L O T ) ;  
 	 	 	 d o u b l e   m a r g i n _ r e q u i r e d     =   M a r k e t I n f o ( s y m b o l , M O D E _ M A R G I N R E Q U I R E D ) ;  
 	 	 	 s t a t i c   b o o l   n o t _ e n o u g h _ m e s s a g e   =   f a l s e ;  
 	 	 	  
 	 	 	 i f   ( m a r g i n _ r e q u i r e d   ! =   0 )  
 	 	 	 {  
 	 	 	 	 d o u b l e   m a x _ s i z e _ b y _ m a r g i n   =   A c c o u n t F r e e M a r g i n ( )   /   m a r g i n _ r e q u i r e d ;  
  
 	 	 	 	 i f   ( l o t s   >   m a x _ s i z e _ b y _ m a r g i n )  
 	 	 	 	 {  
 	 	 	 	 	 d o u b l e   s i z e _ o l d   =   l o t s ;  
 	 	 	 	 	 l o t s   =   m a x _ s i z e _ b y _ m a r g i n ;  
  
 	 	 	 	 	 i f   ( l o t s   <   M i n L o t s )  
 	 	 	 	 	 {  
 	 	 	 	 	 	 i f   ( n o t _ e n o u g h _ m e s s a g e   = =   f a l s e )  
 	 	 	 	 	 	 {  
 	 	 	 	 	 	 	 P r i n t ( " N o t   e n o u g h   m o n e y   t o   t r a d e   : (   T h e   r o b o t   i s   s t i l l   w o r k i n g ,   w a i t i n g   f o r   s o m e   f u n d s   t o   a p p e a r . . . " ) ;  
 	 	 	 	 	 	 }  
  
 	 	 	 	 	 	 n o t _ e n o u g h _ m e s s a g e   =   t r u e ;  
 	 	 	 	 	 	 r e t u r n   f a l s e ;  
 	 	 	 	 	 }  
 	 	 	 	 	 e l s e  
 	 	 	 	 	 {  
 	 	 	 	 	 	 l o t s   =   M a t h F l o o r ( l o t s   /   L o t S t e p )   *   L o t S t e p ;  
  
 	 	 	 	 	 	 P r i n t ( " N o t   e n o u g h   m o n e y   t o   t r a d e   "   +   D o u b l e T o S t r i n g ( s i z e _ o l d ,   2 ) + " ,   t h e   v o l u m e   t o   t r a d e   w i l l   b e   t h e   m a x i m u m   p o s s i b l e   o f   "   +   D o u b l e T o S t r i n g ( l o t s ,   2 ) ) ;  
 	 	 	 	 	 }  
 	 	 	 	 }  
 	 	 	 }  
  
 	 	 	 n o t _ e n o u g h _ m e s s a g e   =   f a l s e ;  
 	 	 }  
 	 	  
 	 	 / /   f i x   t h e   c o m m e n t ,   b e c a u s e   i t   s e e m s   t h a t   t h e   c o m m e n t   i s   d e l e t e d   i f   i t s   l e n g h t   i s   >   3 1   s y m b o l s  
 	 	 i f   ( S t r i n g L e n ( c o m m e n t )   >   3 1 )  
 	 	 {  
 	 	 	 c o m m e n t   =   S t r i n g S u b s t r ( c o m m e n t , 0 , 3 1 ) ;  
 	 	 }  
 	 	  
 	 	 / / -   e x p i r a t i o n   f o r   t r a d e s  
 	 	 i f   ( t y p e   = =   O P _ B U Y   | |   t y p e   = =   O P _ S E L L )  
 	 	 {  
 	 	 	 i f   ( e x p i r a t i o n   >   0 )  
 	 	 	 {  
 	 	 	 	 / / -   c o n v e r t   U N I X   t o   s e c o n d s  
 	 	 	 	 i f   ( e x p i r a t i o n   >   T i m e C u r r e n t ( ) - 1 0 0 )   {  
 	 	 	 	 	 e x p i r a t i o n   =   e x p i r a t i o n   -   T i m e C u r r e n t ( ) ;  
 	 	 	 	 }  
 	 	 	 	  
 	 	 	 	 / / -   b o   b r o k e r ?  
 	 	 	 	 i f   (  
 	 	 	 	 	       S t r i n g L e n ( s y m b o l )   >   6  
 	 	 	 	 	 & &   S t r i n g S u b s t r ( s y m b o l ,   S t r i n g L e n ( s y m b o l )   -   2 )   = =   " b o "  
 	 	 	 	 )   {  
 	 	 	 	 	 c o m m e n t   =   " B O   e x p : "   +   ( s t r i n g ) e x p i r a t i o n ;  
 	 	 	 	 }  
 	 	 	 	 e l s e  
 	 	 	 	 {  
 	 	 	 	 	 s t r i n g   e x p i r a t i o n _ s t r   =   " [ e x p : "   +   I n t e g e r T o S t r i n g ( e x p i r a t i o n )   +   " ] " ;  
 	 	 	 	 	 i n t   e x p i r a t i o n _ l e n         =   S t r i n g L e n ( e x p i r a t i o n _ s t r ) ;  
 	 	 	 	 	 i n t   c o m m e n t _ l e n               =   S t r i n g L e n ( c o m m e n t ) ;  
  
 	 	 	 	 	 i f   ( c o m m e n t _ l e n   >   ( 2 7   -   e x p i r a t i o n _ l e n ) )  
 	 	 	 	 	 {  
 	 	 	 	 	 	 c o m m e n t   =   S t r i n g S u b s t r ( c o m m e n t ,   0 ,   ( 2 7   -   e x p i r a t i o n _ l e n ) ) ;  
 	 	 	 	 	 }  
  
 	 	 	 	 	 c o m m e n t   =   c o m m e n t   +   e x p i r a t i o n _ s t r ;  
 	 	 	 	 }  
 	 	 	 }  
 	 	 }  
  
 	 	 i f   ( t y p e   = =   O P _ B U Y   | |   t y p e   = =   O P _ S E L L )  
 	 	 {  
 	 	 	 o p   =   ( b s   >   0 )   ?   a s k   :   b i d ;  
 	 	 }  
  
 	 	 o p     =   N o r m a l i z e D o u b l e ( o p ,   d i g i t s ) ;  
 	 	 s l l   =   N o r m a l i z e D o u b l e ( s l l ,   d i g i t s ) ;  
 	 	 t p l   =   N o r m a l i z e D o u b l e ( t p l ,   d i g i t s ) ;  
  
 	 	 i f   ( o p   <   0   | |   o p   > =   E M P T Y _ V A L U E   | |   s l l   <   0   | |   s l p   <   0   | |   t p l   <   0   | |   t p p   <   0 )  
 	 	 {  
 	 	 	 b r e a k ;  
 	 	 }  
  
 	 	 / / - -   S L   a n d   T P   - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  
 	 	 v s l   =   0 ;   v t p   =   0 ;  
 	 	  
 	 	 s l   =   A l i g n S t o p L o s s ( s y m b o l ,   t y p e ,   o p ,   0 ,   N o r m a l i z e D o u b l e ( s l l ,   d i g i t s ) ,   s l p ) ;  
  
 	 	 i f   ( s l   <   0 )   { b r e a k ; }  
  
 	 	 t p   =   A l i g n T a k e P r o f i t ( s y m b o l ,   t y p e ,   o p ,   0 ,   N o r m a l i z e D o u b l e ( t p l ,   d i g i t s ) ,   t p p ) ;  
  
 	 	 i f   ( t p   <   0 )   { b r e a k ; }  
 	 	  
 	 	 i f   ( U S E _ V I R T U A L _ S T O P S )  
 	 	 {  
 	 	 	 / / - -   v i r t u a l   S L   a n d   T P   - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  
 	 	 	 v s l   =   s l ;  
 	 	 	 v t p   =   t p ;  
 	 	 	 s l   =   0 ;  
 	 	 	 t p   =   0 ;  
  
 	 	 	 d o u b l e   a s k b i d   =   ( b s   >   0 )   ?   a s k   :   b i d ;  
  
 	 	 	 i f   ( v s l   >   0   | |   U S E _ E M E R G E N C Y _ S T O P S   = =   " a l w a y s " )  
 	 	 	 {  
 	 	 	 	 i f   ( E M E R G E N C Y _ S T O P S _ R E L   >   0   | |   E M E R G E N C Y _ S T O P S _ A D D   >   0 )  
 	 	 	 	 {  
 	 	 	 	 	 s l   =   v s l   -   E M E R G E N C Y _ S T O P S _ R E L   *   M a t h A b s ( a s k b i d   -   v s l )   *   b s ;  
  
 	 	 	 	 	 i f   ( s l   < =   0 )   { s l   =   a s k b i d ; }  
  
 	 	 	 	 	 s l   =   s l   -   t o D i g i t s ( E M E R G E N C Y _ S T O P S _ A D D ,   s y m b o l )   *   b s ;  
 	 	 	 	 }  
 	 	 	 }  
  
 	 	 	 i f   ( v t p   >   0   | |   U S E _ E M E R G E N C Y _ S T O P S   = =   " a l w a y s " )  
 	 	 	 {  
 	 	 	 	 i f   ( E M E R G E N C Y _ S T O P S _ R E L   >   0   | |   E M E R G E N C Y _ S T O P S _ A D D   >   0 )  
 	 	 	 	 {  
 	 	 	 	 	 t p   =   v t p   +   E M E R G E N C Y _ S T O P S _ R E L   *   M a t h A b s ( v t p   -   a s k b i d )   *   b s ;  
  
 	 	 	 	 	 i f   ( t p   < =   0 )   { t p   =   a s k b i d ; }  
  
 	 	 	 	 	 t p   =   t p   +   t o D i g i t s ( E M E R G E N C Y _ S T O P S _ A D D ,   s y m b o l )   *   b s ;  
 	 	 	 	 }  
 	 	 	 }  
  
 	 	 	 v s l   =   N o r m a l i z e D o u b l e ( v s l ,   d i g i t s ) ;  
 	 	 	 v t p   =   N o r m a l i z e D o u b l e ( v t p ,   d i g i t s ) ;  
 	 	 }  
  
 	 	 s l   =   N o r m a l i z e D o u b l e ( s l ,   d i g i t s ) ;  
 	 	 t p   =   N o r m a l i z e D o u b l e ( t p ,   d i g i t s ) ;  
  
 	 	 / / - -   f i x   e x p i r a t i o n   f o r   p e n d i n g   o r d e r s   - - - - - - - - - - - - - - - - - - - - - - - - - - - -  
 	 	 i f   ( e x p i r a t i o n   >   0   & &   t y p e   >   O P _ S E L L )  
 	 	 {  
 	 	 	 i f   ( ( e x p i r a t i o n   -   T i m e C u r r e n t ( ) )   <   ( 1 1   *   6 0 ) )  
 	 	 	 {  
 	 	 	 	 P r i n t ( " E x p i r a t i o n   t i m e   c a n n o t   b e   l e s s   t h a n   1 1   m i n u t e s ,   s o   i t   w a s   a u t o m a t i c a l l y   m o d i f i e d   t o   1 1   m i n u t e s . " ) ;  
 	 	 	 	 e x p i r a t i o n   =   T i m e C u r r e n t ( )   +   ( 1 1   *   6 0 ) ;  
 	 	 	 }  
 	 	 }  
  
 	 	 / / - -   f i x   p r i c e s   b y   t i c k s i z e  
 	 	 o p   =   M a t h R o u n d ( o p   /   t i c k s i z e )   *   t i c k s i z e ;  
 	 	 s l   =   M a t h R o u n d ( s l   /   t i c k s i z e )   *   t i c k s i z e ;  
 	 	 t p   =   M a t h R o u n d ( t p   /   t i c k s i z e )   *   t i c k s i z e ;  
  
 	 	 / / - -   s e n d   - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  
 	 	 R e s e t L a s t E r r o r ( ) ;  
  
 	 	 t i c k e t   =   O r d e r S e n d (  
 	 	 	 s y m b o l ,  
 	 	 	 t y p e ,  
 	 	 	 l o t s ,  
 	 	 	 o p ,  
 	 	 	 ( i n t ) ( s l i p p a g e   *   P i p V a l u e ( s y m b o l ) ) ,  
 	 	 	 s l ,  
 	 	 	 t p ,  
 	 	 	 c o m m e n t ,  
 	 	 	 m a g i c ,  
 	 	 	 e x p i r a t i o n ,  
 	 	 	 a r r o w c o l o r  
 	 	 ) ;  
  
 	 	 / / - -   e r r o r   c h e c k   - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  
 	 	 s t r i n g   m s g _ p r e f i x   =   ( t y p e   >   O P _ S E L L )   ?   " N e w   o r d e r   e r r o r "   :   " N e w   t r a d e   e r r o r " ;  
  
 	 	 i n t   e r r a c t i o n   =   C h e c k F o r T r a d i n g E r r o r ( G e t L a s t E r r o r ( ) ,   m s g _ p r e f i x ) ;  
  
 	 	 s w i t c h ( e r r a c t i o n )  
 	 	 {  
 	 	 	 c a s e   0 :   b r e a k ;         / /   n o   e r r o r  
 	 	 	 c a s e   1 :   c o n t i n u e ;   / /   o v e r c o m a b l e   e r r o r  
 	 	 	 c a s e   2 :   b r e a k ;         / /   f a t a l   e r r o r  
 	 	 }  
  
 	 	 / / - -   f i n i s h   w o r k   - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  
 	 	 i f   ( t i c k e t   >   0 )  
 	 	 {  
 	 	 	 i f   ( U S E _ V I R T U A L _ S T O P S )  
 	 	 	 {  
 	 	 	 	 V i r t u a l S t o p s D r i v e r ( " s e t " ,   t i c k e t ,   v s l ,   v t p ,   t o P i p s ( M a t h A b s ( o p - v s l ) ,   s y m b o l ) ,   t o P i p s ( M a t h A b s ( v t p - o p ) ,   s y m b o l ) ) ;  
 	 	 	 }  
 	 	 	  
 	 	 	 / / - -   s h o w   s o m e   i n f o  
 	 	 	 d o u b l e   s l i p   =   0 ;  
  
 	 	 	 i f   ( O r d e r S e l e c t ( t i c k e t ,   S E L E C T _ B Y _ T I C K E T ) )  
 	 	 	 {  
 	 	 	 	 i f   (  
 	 	 	 	 	       ! M Q L I n f o I n t e g e r ( M Q L _ T E S T E R )  
 	 	 	 	 	 & &   ! M Q L I n f o I n t e g e r ( M Q L _ V I S U A L _ M O D E )  
 	 	 	 	 	 & &   ! M Q L I n f o I n t e g e r ( M Q L _ O P T I M I Z A T I O N )  
 	 	 	 	 )   {  
 	 	 	 	 	 s l i p   =   O r d e r O p e n P r i c e ( )   -   o p ;  
  
 	 	 	 	 	 P r i n t (  
 	 	 	 	 	 	 " O p e r a t i o n   d e t a i l s :   S p e e d   " ,  
 	 	 	 	 	 	 ( G e t T i c k C o u n t ( )   -   t i m e 0 ) ,  
 	 	 	 	 	 	 "   m s   |   S l i p p a g e   " ,  
 	 	 	 	 	 	 D o u b l e T o S t r ( t o P i p s ( s l i p ,   s y m b o l ) ,   1 ) ,  
 	 	 	 	 	 	 "   p i p s "  
 	 	 	 	 	 ) ;  
 	 	 	 	 }  
 	 	 	 }  
  
 	 	 	 / / - -   f i x   s t o p s   i n   c a s e   o f   s l i p p a g e  
 	 	 	 i f   (  
 	 	 	 	       ! M Q L I n f o I n t e g e r ( M Q L _ T E S T E R )  
 	 	 	 	 & &   ! M Q L I n f o I n t e g e r ( M Q L _ V I S U A L _ M O D E )  
 	 	 	 	 & & ! M Q L I n f o I n t e g e r ( M Q L _ O P T I M I Z A T I O N )  
 	 	 	 )   {  
 	 	 	 	 s l i p   =   N o r m a l i z e D o u b l e ( O r d e r O p e n P r i c e ( ) ,   d i g i t s )   -   N o r m a l i z e D o u b l e ( o p ,   d i g i t s ) ;  
  
 	 	 	 	 i f   ( s l i p   ! =   0   & &   ( O r d e r S t o p L o s s ( )   ! =   0   | |   O r d e r T a k e P r o f i t ( )   ! =   0 ) )  
 	 	 	 	 {  
 	 	 	 	 	 P r i n t ( " C o r r e c t i n g   s t o p s   b e c a u s e   o f   s l i p p a g e . . . " ) ;  
  
 	 	 	 	 	 s l   =   O r d e r S t o p L o s s ( ) ;  
 	 	 	 	 	 t p   =   O r d e r T a k e P r o f i t ( ) ;  
  
 	 	 	 	 	 i f   ( s l   ! =   0   | |   t p   ! =   0 )  
 	 	 	 	 	 {  
 	 	 	 	 	 	 i f   ( s l   ! =   0 )   { s l   =   N o r m a l i z e D o u b l e ( O r d e r S t o p L o s s ( )   +   s l i p ,   d i g i t s ) ; }  
 	 	 	 	 	 	 i f   ( t p   ! =   0 )   { t p   =   N o r m a l i z e D o u b l e ( O r d e r T a k e P r o f i t ( )   +   s l i p ,   d i g i t s ) ; }  
  
 	 	 	 	 	 	 M o d i f y O r d e r ( t i c k e t ,   O r d e r O p e n P r i c e ( ) ,   s l ,   t p ,   0 ,   0 ,   0 ,   C L R _ N O N E ,   f a l s e ) ;  
 	 	 	 	 	 }  
 	 	 	 	 }  
 	 	 	 }  
  
 	 	 	 R e g i s t e r E v e n t ( " t r a d e " ) ;  
  
 	 	 	 b r e a k ;  
 	 	 }  
  
 	 	 b r e a k ;  
 	 }  
  
 	 i f   ( o c o   = =   t r u e   & &   t i c k e t   >   0 )  
 	 {  
 	 	 i f   ( U S E _ V I R T U A L _ S T O P S )  
 	 	 {  
 	 	 	 s l   =   v s l ;  
 	 	 	 t p   =   v t p ;  
 	 	 }  
  
 	 	 s l   =   ( s l   >   0 )   ?   N o r m a l i z e D o u b l e ( M a t h A b s ( o p - s l ) ,   d i g i t s )   :   0 ;  
 	 	 t p   =   ( t p   >   0 )   ?   N o r m a l i z e D o u b l e ( M a t h A b s ( o p - t p ) ,   d i g i t s )   :   0 ;  
  
 	 	 i n t   t y p e o c o   =   t y p e ;  
  
 	 	 i f   ( t y p e o c o   = =   O P _ B U Y S T O P )  
 	 	 {  
 	 	 	 t y p e o c o   =   O P _ S E L L S T O P ;  
 	 	 	 o p   =   b i d   -   M a t h A b s ( o p   -   a s k ) ;  
 	 	 }  
 	 	 e l s e   i f   ( t y p e o c o   = =   O P _ B U Y L I M I T )  
 	 	 {  
 	 	 	 t y p e o c o   =   O P _ S E L L L I M I T ;  
 	 	 	 o p   =   b i d   +   M a t h A b s ( o p   -   a s k ) ;  
 	 	 }  
 	 	 e l s e   i f   ( t y p e o c o   = =   O P _ S E L L S T O P )  
 	 	 {  
 	 	 	 t y p e o c o   =   O P _ B U Y S T O P ;  
 	 	 	 o p   =   a s k   +   M a t h A b s ( o p   -   b i d ) ;  
 	 	 }  
 	 	 e l s e   i f   ( t y p e o c o   = =   O P _ S E L L L I M I T )  
 	 	 {  
 	 	 	 t y p e o c o   =   O P _ B U Y L I M I T ;  
 	 	 	 o p   =   a s k   -   M a t h A b s ( o p   -   b i d ) ;  
 	 	 }  
  
 	 	 i f   ( t y p e o c o   = =   O P _ B U Y S T O P   | |   t y p e o c o   = =   O P _ B U Y L I M I T )  
 	 	 {  
 	 	 	 s l   =   ( s l   >   0 )   ?   o p   -   s l   :   0 ;  
 	 	 	 t p   =   ( t p   >   0 )   ?   o p   +   t p   :   0 ;  
 	 	 	 a r r o w c o l o r   =   c l r B l u e ;  
 	 	 }  
 	 	 e l s e  
 	 	 {  
 	 	 	 s l   =   ( s l   >   0 )   ?   o p   +   s l   :   0 ;  
 	 	 	 t p   =   ( t p   >   0 )   ?   o p   -   t p   :   0 ;  
 	 	 	 a r r o w c o l o r   =   c l r R e d ;  
 	 	 }  
  
 	 	 c o m m e n t   =   " [ o c o : "   +   ( s t r i n g ) t i c k e t   +   " ] " ;  
  
 	 	 O r d e r C r e a t e ( s y m b o l ,   t y p e o c o ,   l o t s ,   o p ,   s l ,   t p ,   0 ,   0 ,   s l i p p a g e ,   m a g i c ,   c o m m e n t ,   a r r o w c o l o r ,   e x p i r a t i o n ,   f a l s e ) ;  
 	 }  
  
 	 r e t u r n   t i c k e t ;  
 }  
  
 / * *  
 T h i s   i s   a   r e p l a c e m e n t   f o r   t h e   s y s t e m   f u n c t i o n .  
 T h e   d i f f e r e n c e   i s   t h a t   t h i s   c h e c k s   t h e   e x p i r a t i o n   f o r   t r a d e s .  
 * /  
 d a t e t i m e   O r d e r E x p i r a t i o n ( b o o l   c h e c k _ t r a d e )  
 {  
 	 i f   ( O r d e r T y p e ( )   >   1 )  
 	 {  
 	 	 r e t u r n   O r d e r E x p i r a t i o n ( ) ;  
 	 }  
 	 e l s e   i f   ( c h e c k _ t r a d e )  
 	 {  
 	 	 s t r i n g   c o m m e n t   =   O r d e r C o m m e n t ( ) ;  
 	 	 i n t   e x p _ p o s         =   S t r i n g F i n d ( c o m m e n t ,   " [ e x p : " ) ;  
  
 	 	 i f   ( e x p _ p o s   = =   - 1 )   r e t u r n   0 ;  
 	 	  
 	 	 i n t   e x p _ p o s _ e n d   =   S t r i n g F i n d ( c o m m e n t ,   " ] " ,   e x p _ p o s ) ;  
 	 	  
 	 	 i f   ( e x p _ p o s _ e n d   < =   0 )   r e t u r n   0 ;  
  
 	 	 i n t   e x p i r a t i o n _ s e c o n d s   =   ( i n t ) S t r i n g T o I n t e g e r ( S t r i n g S u b s t r ( c o m m e n t ,   e x p _ p o s   +   5 ,   e x p _ p o s _ e n d   -   ( e x p _ p o s   +   5 ) ) ) ;  
  
 	 	 r e t u r n   ( d a t e t i m e ) ( ( i n t ) O r d e r O p e n T i m e ( )   +   e x p i r a t i o n _ s e c o n d s ) ;  
 	 }  
 	  
 	 r e t u r n   0 ;  
 }  
  
 b o o l   O r d e r M o d i f i e d ( u l o n g   t i c k e t   =   0 ,   s t r i n g   a c t i o n   =   " s e t " )  
 {  
 	 s t a t i c   u l o n g   m e m o r y [ ] ;  
  
 	 i f   ( t i c k e t   = =   0 )  
 	 {  
 	 	 t i c k e t   =   O r d e r T i c k e t ( ) ;  
 	 	 a c t i o n   =   " g e t " ;  
 	 }  
 	 e l s e   i f   ( t i c k e t   >   0   & &   a c t i o n   ! =   " c l e a r " )  
 	 {  
 	 	 a c t i o n   =   " s e t " ;  
 	 }  
  
 	 b o o l   m o d i f i e d _ s t a t u s   =   I n A r r a y ( m e m o r y ,   t i c k e t ) ;  
 	  
 	 i f   ( a c t i o n   = =   " g e t " )  
 	 {  
 	 	 r e t u r n   m o d i f i e d _ s t a t u s ;  
 	 }  
 	 e l s e   i f   ( a c t i o n   = =   " s e t " )  
 	 {  
 	 	 A r r a y E n s u r e V a l u e ( m e m o r y ,   t i c k e t ) ;  
  
 	 	 r e t u r n   t r u e ;  
 	 }  
 	 e l s e   i f   ( a c t i o n   = =   " c l e a r " )  
 	 {  
 	 	 A r r a y S t r i p V a l u e ( m e m o r y ,   t i c k e t ) ;  
  
 	 	 r e t u r n   t r u e ;  
 	 }  
  
 	 r e t u r n   f a l s e ;  
 }  
  
 b o o l   P e n d i n g O r d e r S e l e c t B y T i c k e t ( u l o n g   t i c k e t )  
 {  
 	 i f   ( O r d e r S e l e c t ( ( i n t ) t i c k e t ,   S E L E C T _ B Y _ T I C K E T ,   M O D E _ T R A D E S )   & &   O r d e r T y p e ( )   >   1 )  
 	 {  
 	 	 r e t u r n   t r u e ;  
 	 }  
  
 	 r e t u r n   f a l s e ;  
 }  
  
 d o u b l e   P i p V a l u e ( s t r i n g   s y m b o l )  
 {  
 	 i f   ( s y m b o l   = =   " " )   s y m b o l   =   S y m b o l ( ) ;  
  
 	 r e t u r n   C u s t o m P o i n t ( s y m b o l )   /   S y m b o l I n f o D o u b l e ( s y m b o l ,   S Y M B O L _ P O I N T ) ;  
 }  
  
 / /   C o l l e c t   e v e n t s ,   i f   a n y  
 v o i d   R e g i s t e r E v e n t ( s t r i n g   c o m m a n d = " " )  
 {  
       i n t   t i c k e t = O r d e r T i c k e t ( ) ;  
 	 O n T r a d e L i s t e n e r ( ) ;  
       t i c k e t = O r d e r S e l e c t ( t i c k e t , S E L E C T _ B Y _ T I C K E T ) ;  
       r e t u r n ;  
 }  
  
 i n t   S e c o n d s F r o m C o m p o n e n t s ( d o u b l e   d a y s ,   d o u b l e   h o u r s ,   d o u b l e   m i n u t e s ,   i n t   s e c o n d s )  
 {  
 	 i n t   r e t v a l   =  
 	 	 8 6 4 0 0   *   ( i n t ) M a t h F l o o r ( d a y s )  
 	 	 +   3 6 0 0   *   ( i n t ) ( M a t h F l o o r ( h o u r s )   +   ( 2 4   *   ( d a y s   -   M a t h F l o o r ( d a y s ) ) ) )  
 	 	 +   6 0   *   ( i n t ) ( M a t h F l o o r ( m i n u t e s )   +   ( 6 0   *   ( h o u r s   -   M a t h F l o o r ( h o u r s ) ) ) )  
 	 	 +   ( i n t ) ( ( d o u b l e ) s e c o n d s   +   ( 6 0   *   ( m i n u t e s   -   M a t h F l o o r ( m i n u t e s ) ) ) ) ;  
  
 	 r e t u r n   r e t v a l ;  
 }  
  
 t e m p l a t e < t y p e n a m e   T >  
 v o i d   S t r i n g E x p l o d e ( s t r i n g   d e l i m i t e r ,   s t r i n g   i n p u t S t r i n g ,   T   & o u t p u t [ ] )  
 {  
 	 i n t   b e g i n       =   0 ;  
 	 i n t   e n d           =   0 ;  
 	 i n t   e l e m e n t   =   0 ;  
 	 i n t   l e n g t h     =   S t r i n g L e n ( i n p u t S t r i n g ) ;  
 	 i n t   l e n g t h _ d e l i m i t e r   =   S t r i n g L e n ( d e l i m i t e r ) ;  
 	 T   e m p t y _ v a l     =   ( t y p e n a m e ( T )   = =   " s t r i n g " )   ?   ( T ) " "   :   ( T ) 0 ;  
  
 	 i f   ( l e n g t h   >   0 )  
 	 {  
 	 	 w h i l e   ( t r u e )  
 	 	 {  
 	 	 	 e n d   =   S t r i n g F i n d ( i n p u t S t r i n g ,   d e l i m i t e r ,   b e g i n ) ;  
  
 	 	 	 A r r a y R e s i z e ( o u t p u t ,   e l e m e n t   +   1 ) ;  
 	 	 	 o u t p u t [ e l e m e n t ]   =   e m p t y _ v a l ;  
 	  
 	 	 	 i f   ( e n d   ! =   - 1 )  
 	 	 	 {  
 	 	 	 	 i f   ( e n d   >   b e g i n )  
 	 	 	 	 {  
 	 	 	 	 	 o u t p u t [ e l e m e n t ]   =   ( T ) S t r i n g S u b s t r ( i n p u t S t r i n g ,   b e g i n ,   e n d   -   b e g i n ) ;  
 	 	 	 	 }  
 	 	 	 }  
 	 	 	 e l s e  
 	 	 	 {  
 	 	 	 	 o u t p u t [ e l e m e n t ]   =   ( T ) S t r i n g S u b s t r ( i n p u t S t r i n g ,   b e g i n ,   l e n g t h   -   b e g i n ) ;  
 	 	 	 	 b r e a k ;  
 	 	 	 }  
 	 	 	  
 	 	 	 b e g i n   =   e n d   +   1   +   ( l e n g t h _ d e l i m i t e r   -   1 ) ;  
 	 	 	 e l e m e n t + + ;  
 	 	 }  
 	 }  
 	 e l s e  
 	 {  
 	 	 A r r a y R e s i z e ( o u t p u t ,   1 ) ;  
 	 	 o u t p u t [ e l e m e n t ]   =   e m p t y _ v a l ;  
 	 }  
 }  
  
 t e m p l a t e < t y p e n a m e   T >  
 s t r i n g   S t r i n g I m p l o d e ( s t r i n g   d e l i m e t e r ,   T   & a r r a y [ ] )  
 {  
       s t r i n g   r e t v a l   =   " " ;  
       i n t   s i z e             =   A r r a y S i z e ( a r r a y ) ;  
  
       f o r   ( i n t   i   =   0 ;   i   <   s i z e ;   i + + )  
 	 {  
             r e t v a l   =   S t r i n g C o n c a t e n a t e ( r e t v a l ,   ( s t r i n g ) a r r a y [ i ] ,   d e l i m e t e r ) ;  
       }  
 	  
       r e t u r n   S t r i n g S u b s t r ( r e t v a l ,   0 ,   ( S t r i n g L e n ( r e t v a l )   -   S t r i n g L e n ( d e l i m e t e r ) ) ) ;  
 }  
  
 s t r i n g   S t r i n g T r i m ( s t r i n g   t e x t )  
 {  
       t e x t   =   S t r i n g T r i m R i g h t ( t e x t ) ;  
       t e x t   =   S t r i n g T r i m L e f t ( t e x t ) ;  
 	  
 	 r e t u r n   t e x t ;  
 }  
  
 d o u b l e   S y m b o l A s k ( s t r i n g   s y m b o l )  
 {  
 	 i f   ( s y m b o l   = =   " " )   s y m b o l   =   S y m b o l ( ) ;  
  
 	 r e t u r n   S y m b o l I n f o D o u b l e ( s y m b o l ,   S Y M B O L _ A S K ) ;  
 }  
  
 i n t   S y m b o l D i g i t s ( s t r i n g   s y m b o l )  
 {  
 	 i f   ( s y m b o l   = =   " " )   s y m b o l   =   S y m b o l ( ) ;  
  
 	 r e t u r n   ( i n t ) S y m b o l I n f o I n t e g e r ( s y m b o l ,   S Y M B O L _ D I G I T S ) ;  
 }  
  
 d o u b l e   T i c k s D a t a ( s t r i n g   s y m b o l   =   " " ,   i n t   t y p e   =   0 ,   i n t   s h i f t   =   0 )  
 {  
 	 s t a t i c   b o o l   c o l l e c t i n g _ t i c k s   =   f a l s e ;  
 	 s t a t i c   s t r i n g   s y m b o l s [ ] ;  
 	 s t a t i c   i n t   z e r o _ s i d [ ] ;  
 	 s t a t i c   d o u b l e   m e m o r y A S K [ ] [ 1 0 0 ] ;  
 	 s t a t i c   d o u b l e   m e m o r y B I D [ ] [ 1 0 0 ] ;  
  
 	 i n t   s i d   =   0 ,   s i z e   =   0 ,   i   =   0 ,   i d   =   0 ;  
 	 d o u b l e   a s k   =   0 ,   b i d   =   0 ,   r e t v a l   =   0 ;  
 	 b o o l   e x i s t s   =   f a l s e ;  
  
 	 i f   ( A r r a y S i z e ( s y m b o l s )   = =   0 )  
 	 {  
 	 	 A r r a y R e s i z e ( s y m b o l s ,   1 ) ;  
 	 	 A r r a y R e s i z e ( z e r o _ s i d ,   1 ) ;  
 	 	 A r r a y R e s i z e ( m e m o r y A S K ,   1 ) ;  
 	 	 A r r a y R e s i z e ( m e m o r y B I D ,   1 ) ;  
  
 	 	 s y m b o l s [ 0 ]   =   _ S y m b o l ;  
 	 }  
  
 	 i f   ( t y p e   >   0   & &   s h i f t   >   0 )  
 	 {  
 	 	 c o l l e c t i n g _ t i c k s   =   t r u e ;  
 	 }  
  
 	 i f   ( c o l l e c t i n g _ t i c k s   = =   f a l s e )  
 	 {  
 	 	 i f   ( t y p e   >   0   & &   s h i f t   = =   0 )  
 	 	 {  
 	 	 	 / /   g o i n g   t o   g e t   t i c k s  
 	 	 }  
 	 	 e l s e  
 	 	 {  
 	 	 	 r e t u r n   0 ;  
 	 	 }  
 	 }  
  
 	 i f   ( s y m b o l   = =   " " )   s y m b o l   =   _ S y m b o l ;  
  
 	 i f   ( t y p e   = =   0 )  
 	 {  
 	 	 e x i s t s   =   f a l s e ;  
 	 	 s i z e       =   A r r a y S i z e ( s y m b o l s ) ;  
  
 	 	 i f   ( s i z e   = =   0 )   { A r r a y R e s i z e ( s y m b o l s ,   1 ) ; }  
  
 	 	 f o r   ( i = 0 ;   i < s i z e ;   i + + )  
 	 	 {  
 	 	 	 i f   ( s y m b o l s [ i ]   = =   s y m b o l )  
 	 	 	 {  
 	 	 	 	 e x i s t s   =   t r u e ;  
 	 	 	 	 s i d         =   i ;  
 	 	 	 	 b r e a k ;  
 	 	 	 }  
 	 	 }  
  
 	 	 i f   ( e x i s t s   = =   f a l s e )  
 	 	 {  
 	 	 	 i n t   n e w s i z e   =   A r r a y S i z e ( s y m b o l s )   +   1 ;  
  
 	 	 	 A r r a y R e s i z e ( s y m b o l s ,   n e w s i z e ) ;  
 	 	 	 s y m b o l s [ n e w s i z e - 1 ]   =   s y m b o l ;  
  
 	 	 	 A r r a y R e s i z e ( z e r o _ s i d ,   n e w s i z e ) ;  
 	 	 	 A r r a y R e s i z e ( m e m o r y A S K ,   n e w s i z e ) ;  
 	 	 	 A r r a y R e s i z e ( m e m o r y B I D ,   n e w s i z e ) ;  
  
 	 	 	 s i d = n e w s i z e ;  
 	 	 }  
  
 	 	 i f   ( s i d   > =   0 )  
 	 	 {  
 	 	 	 a s k   =   S y m b o l I n f o D o u b l e ( s y m b o l ,   S Y M B O L _ A S K ) ;  
 	 	 	 b i d   =   S y m b o l I n f o D o u b l e ( s y m b o l ,   S Y M B O L _ B I D ) ;  
  
 	 	 	 i f   ( b i d   = =   0   & &   M Q L I n f o I n t e g e r ( M Q L _ T E S T E R ) )  
 	 	 	 {  
 	 	 	 	 P r i n t ( " T i c k s   d a t a   c o l l e c t o r   e r r o r :   "   +   s y m b o l   +   "   c a n n o t   b e   b a c k t e s t e d .   O n l y   t h e   c u r r e n t   s y m b o l   c a n   b e   b a c k t e s t e d .   T h e   E A   w i l l   b e   t e r m i n a t e d . " ) ;  
 	 	 	 	 E x p e r t R e m o v e ( ) ;  
 	 	 	 }  
  
 	 	 	 i f   (  
 	 	 	 	       s y m b o l   = =   _ S y m b o l  
 	 	 	 	 | |   a s k   ! =   m e m o r y A S K [ s i d ] [ 0 ]  
 	 	 	 	 | |   b i d   ! =   m e m o r y B I D [ s i d ] [ 0 ]  
 	 	 	 )  
 	 	 	 {  
 	 	 	 	 m e m o r y A S K [ s i d ] [ z e r o _ s i d [ s i d ] ]   =   a s k ;  
 	 	 	 	 m e m o r y B I D [ s i d ] [ z e r o _ s i d [ s i d ] ]   =   b i d ;  
 	 	 	 	 z e r o _ s i d [ s i d ]                                   =   z e r o _ s i d [ s i d ]   +   1 ;  
  
 	 	 	 	 i f   ( z e r o _ s i d [ s i d ]   = =   1 0 0 )  
 	 	 	 	 {  
 	 	 	 	 	 z e r o _ s i d [ s i d ]   =   0 ;  
 	 	 	 	 }  
 	 	 	 }  
 	 	 }  
 	 }  
 	 e l s e  
 	 {  
 	 	 i f   ( s h i f t   < =   0 )  
 	 	 {  
 	 	 	 i f   ( t y p e   = =   S Y M B O L _ A S K )  
 	 	 	 {  
 	 	 	 	 r e t u r n   S y m b o l I n f o D o u b l e ( s y m b o l ,   S Y M B O L _ A S K ) ;  
 	 	 	 }  
 	 	 	 e l s e   i f   ( t y p e   = =   S Y M B O L _ B I D )  
 	 	 	 {  
 	 	 	 	 r e t u r n   S y m b o l I n f o D o u b l e ( s y m b o l ,   S Y M B O L _ B I D ) ;    
 	 	 	 }  
 	 	 	 e l s e  
 	 	 	 {  
 	 	 	 	 d o u b l e   m i d   =   ( ( S y m b o l I n f o D o u b l e ( s y m b o l ,   S Y M B O L _ A S K )   +   S y m b o l I n f o D o u b l e ( s y m b o l ,   S Y M B O L _ B I D ) )   /   2 ) ;  
  
 	 	 	 	 r e t u r n   m i d ;  
 	 	 	 }  
 	 	 }  
 	 	 e l s e  
 	 	 {  
 	 	 	 s i z e   =   A r r a y S i z e ( s y m b o l s ) ;  
  
 	 	 	 f o r   ( i   =   0 ;   i   <   s i z e ;   i + + )  
 	 	 	 {  
 	 	 	 	 i f   ( s y m b o l s [ i ]   = =   s y m b o l )  
 	 	 	 	 {  
 	 	 	 	 	 s i d   =   i ;  
 	 	 	 	 }  
 	 	 	 }  
  
 	 	 	 i f   ( s h i f t   <   1 0 0 )  
 	 	 	 {  
 	 	 	 	 i d   =   z e r o _ s i d [ s i d ]   -   s h i f t   -   1 ;  
  
 	 	 	 	 i f ( i d   <   0 )   { i d   =   i d   +   1 0 0 ; }  
  
 	 	 	 	 i f   ( t y p e   = =   S Y M B O L _ A S K )  
 	 	 	 	 {  
 	 	 	 	 	 r e t v a l   =   m e m o r y A S K [ s i d ] [ i d ] ;  
  
 	 	 	 	 	 i f   ( r e t v a l   = =   0 )  
 	 	 	 	 	 {  
 	 	 	 	 	 	 r e t v a l   =   S y m b o l I n f o D o u b l e ( s y m b o l ,   S Y M B O L _ A S K ) ;  
 	 	 	 	 	 }  
 	 	 	 	 }  
 	 	 	 	 e l s e   i f   ( t y p e   = =   S Y M B O L _ B I D )  
 	 	 	 	 {  
 	 	 	 	 	 r e t v a l   =   m e m o r y B I D [ s i d ] [ i d ] ;  
  
 	 	 	 	 	 i f   ( r e t v a l   = =   0 )  
 	 	 	 	 	 {  
 	 	 	 	 	 	 r e t v a l   =   S y m b o l I n f o D o u b l e ( s y m b o l ,   S Y M B O L _ B I D ) ;  
 	 	 	 	 	 }  
 	 	 	 	 }  
 	 	 	 }  
 	 	 }  
 	 }  
  
 	 r e t u r n   r e t v a l ;  
 }  
  
 i n t   T i c k s P e r S e c o n d ( b o o l   g e t _ m a x   =   f a l s e ,   b o o l   s e t   =   f a l s e )  
 {  
 	 s t a t i c   d a t e t i m e   t i m e 0   =   0 ;  
 	 s t a t i c   i n t   t i c k s             =   0 ;  
 	 s t a t i c   i n t   t p s                 =   0 ;  
 	 s t a t i c   i n t   t p s m a x           =   0 ;  
  
 	 d a t e t i m e   t i m e 1   =   T i m e L o c a l ( ) ;  
  
 	 i f   ( s e t   = =   t r u e )  
 	 {  
 	 	 i f   ( t i m e 1   >   t i m e 0 )  
 	 	 {  
 	 	 	 i f   ( t i m e 1   -   t i m e 0   >   1 )  
 	 	 	 {  
 	 	 	 	 t p s   =   0 ;  
 	 	 	 }  
 	 	 	 e l s e  
 	 	 	 {  
 	 	 	 	 t p s   =   t i c k s ;  
 	 	 	 }  
  
 	 	 	 t i m e 0   =   t i m e 1 ;  
 	 	 	 t i c k s   =   0 ;  
 	 	 }  
  
 	 	 t i c k s + + ;  
  
 	 	 i f   ( t p s   >   t p s m a x )   { t p s m a x   =   t p s ; }  
 	 }  
  
 	 i f   ( g e t _ m a x )  
 	 {  
 	 	 r e t u r n   t p s m a x ;  
 	 }  
  
 	 r e t u r n   t p s ;  
 }  
  
 d a t e t i m e   T i m e A t S t a r t ( s t r i n g   c m d   =   " s e r v e r " )  
 {  
 	 s t a t i c   d a t e t i m e   l o c a l     =   0 ;  
 	 s t a t i c   d a t e t i m e   s e r v e r   =   0 ;  
  
 	 i f   ( c m d   = =   " l o c a l " )  
 	 {  
 	 	 r e t u r n   l o c a l ;  
 	 }  
 	 e l s e   i f   ( c m d   = =   " s e r v e r " )  
 	 {  
 	 	 r e t u r n   s e r v e r ;  
 	 }  
 	 e l s e   i f   ( c m d   = =   " s e t " )  
 	 {  
 	 	 l o c a l     =   T i m e L o c a l ( ) ;  
 	 	 s e r v e r   =   T i m e C u r r e n t ( ) ;  
 	 }  
  
 	 r e t u r n   0 ;  
 }  
  
 d a t e t i m e   T i m e F r o m C o m p o n e n t s (  
 	 i n t   t i m e _ s r c   =   0 ,  
 	 i n t         y   =   0 ,  
 	 i n t         m   =   0 ,  
 	 d o u b l e   d   =   0 ,  
 	 d o u b l e   h   =   0 ,  
 	 d o u b l e   i   =   0 ,  
 	 i n t         s   =   0  
 )   {  
 	 M q l D a t e T i m e   t m ;  
  
 	           i f   ( t i m e _ s r c   = =   0 )   { T i m e C u r r e n t ( t m ) ; }  
 	 e l s e   i f   ( t i m e _ s r c   = =   1 )   { T i m e L o c a l ( t m ) ; }  
 	 e l s e   i f   ( t i m e _ s r c   = =   2 )   { T i m e G M T ( t m ) ; }  
  
 	 i f   ( y   >   0 )  
 	 {  
 	 	 i f   ( y   <   1 0 0 )   { y   =   2 0 0 0   +   y ; }  
 	 	 t m . y e a r   =   y ;  
 	 }  
 	 i f   ( m   >   0 )   { t m . m o n   =   m ; }  
 	 i f   ( d   >   0 )   { t m . d a y   =   ( i n t ) M a t h F l o o r ( d ) ; }  
  
 	 t m . h o u r   =   ( i n t ) ( M a t h F l o o r ( h )   +   ( 2 4   *   ( d   -   M a t h F l o o r ( d ) ) ) ) ;  
 	 t m . m i n     =   ( i n t ) ( M a t h F l o o r ( i )   +   ( 6 0   *   ( h   -   M a t h F l o o r ( h ) ) ) ) ;  
 	 t m . s e c     =   ( i n t ) ( ( d o u b l e ) s   +   ( 6 0   *   ( i   -   M a t h F l o o r ( i ) ) ) ) ;  
  
 	 r e t u r n   S t r u c t T o T i m e ( t m ) ;  
 }  
  
 b o o l   T r a d e S e l e c t B y I n d e x (  
 	 i n t   i n d e x ,  
 	 s t r i n g   g r o u p _ m o d e         =   " a l l " ,  
 	 s t r i n g   g r o u p                   =   " 0 " ,  
 	 s t r i n g   m a r k e t _ m o d e       =   " a l l " ,  
 	 s t r i n g   m a r k e t                 =   " " ,  
 	 s t r i n g   B u y s O r S e l l s       =   " b o t h "  
 )   {  
 	 i f   ( O r d e r S e l e c t ( ( i n t ) i n d e x ,   S E L E C T _ B Y _ P O S ,   M O D E _ T R A D E S )   & &   O r d e r T y p e ( )   <   2 )  
 	 {  
 	 	 i f   ( F i l t e r O r d e r B y (  
 	 	 	 g r o u p _ m o d e ,  
 	 	 	 g r o u p ,  
 	 	 	 m a r k e t _ m o d e ,  
 	 	 	 m a r k e t ,  
 	 	 	 B u y s O r S e l l s ,  
 	 	 	 " b o t h " ,  
 	 	 	 0 )  
 	 	 )   {  
 	 	 	 r e t u r n   t r u e ;  
 	 	 }  
 	 }  
  
 	 r e t u r n   f a l s e ;  
 }  
  
 b o o l   T r a d e S e l e c t B y T i c k e t ( u l o n g   t i c k e t )  
 {  
 	 i f   ( O r d e r S e l e c t ( ( i n t ) t i c k e t ,   S E L E C T _ B Y _ T I C K E T ,   M O D E _ T R A D E S )   & &   O r d e r T y p e ( )   <   2 )  
 	 {  
 	 	 r e t u r n   t r u e ;  
 	 }  
  
 	 r e t u r n   f a l s e ;  
 }  
  
 i n t   T r a d e s T o t a l ( )  
 {  
 	 r e t u r n   O r d e r s T o t a l ( ) ;  
 }  
  
 v o i d   U p d a t e E v e n t V a l u e s ( s t r i n g   e _ r e a s o n   =   " " , s t r i n g   e _ d e t a i l   =   " " )  
 {  
 	 O n T r a d e Q u e u e ( 1 ) ;  
 	 e _ R e a s o n               ( t r u e ,   e _ r e a s o n ) ;  
 	 e _ R e a s o n D e t a i l   ( t r u e ,   e _ d e t a i l ) ;  
  
 	 e _ a t t r C l o s e P r i c e     ( t r u e ,   O r d e r C l o s e P r i c e ( ) ) ;  
 	 e _ a t t r C l o s e T i m e       ( t r u e ,   O r d e r C l o s e T i m e ( ) ) ;  
 	 e _ a t t r C o m m e n t           ( t r u e ,   O r d e r C o m m e n t ( ) ) ;  
 	 e _ a t t r C o m m i s s i o n     ( t r u e ,   O r d e r C o m m i s s i o n ( ) ) ;  
 	 e _ a t t r E x p i r a t i o n     ( t r u e ,   O r d e r E x p i r a t i o n ( ) ) ;  
 	 e _ a t t r L o t s                 ( t r u e ,   O r d e r L o t s ( ) ) ;  
 	 e _ a t t r M a g i c N u m b e r   ( t r u e ,   O r d e r M a g i c N u m b e r ( ) ) ;  
 	 e _ a t t r O p e n P r i c e       ( t r u e ,   O r d e r O p e n P r i c e ( ) ) ;  
 	 e _ a t t r O p e n T i m e         ( t r u e ,   O r d e r O p e n T i m e ( ) ) ;  
 	 e _ a t t r P r o f i t             ( t r u e ,   O r d e r P r o f i t ( ) ) ;  
 	 e _ a t t r S t o p L o s s         ( t r u e ,   a t t r S t o p L o s s ( ) ) ;  
 	 e _ a t t r S w a p                 ( t r u e ,   O r d e r S w a p ( ) ) ;  
 	 e _ a t t r S y m b o l             ( t r u e ,   O r d e r S y m b o l ( ) ) ;  
 	 e _ a t t r T a k e P r o f i t     ( t r u e ,   a t t r T a k e P r o f i t ( ) ) ;  
 	 e _ a t t r T i c k e t             ( t r u e ,   O r d e r T i c k e t ( ) ) ;  
 	 e _ a t t r T y p e                 ( t r u e ,   O r d e r T y p e ( ) ) ;  
 }  
  
 d o u b l e   V i r t u a l S t o p s D r i v e r (  
 	 s t r i n g   c o m m a n d   =   " " ,  
 	 u l o n g   t i               =   0 ,  
 	 d o u b l e   s l             =   0 ,  
 	 d o u b l e   t p             =   0 ,  
 	 d o u b l e   s l p           =   0 ,  
 	 d o u b l e   t p p           =   0  
 )  
 {  
 	 s t a t i c   b o o l   i n i t i a l i z e d           =   f a l s e ;  
 	 s t a t i c   s t r i n g   n a m e                     =   " " ;  
 	 s t a t i c   s t r i n g   l o o p _ n a m e [ 2 ]     =   { " s l " ,   " t p " } ;  
 	 s t a t i c   c o l o r     l o o p _ c o l o r [ 2 ]   =   { D e e p P i n k ,   D o d g e r B l u e } ;  
 	 s t a t i c   d o u b l e   l o o p _ p r i c e [ 2 ]   =   { 0 ,   0 } ;  
 	 s t a t i c   u l o n g   m e m _ t o _ t i [ ] ;   / /   t i c k e t s  
 	 s t a t i c   i n t   m e m _ t o [ ] ;             / /   t i m e o u t s  
 	 s t a t i c   b o o l   t r a d e _ p a s s   =   f a l s e ;  
 	 i n t   i   =   0 ;  
  
 	 / /   A r e   V i r t u a l   S t o p s   e v e n   e n a b l e d ?  
 	 i f   ( ! U S E _ V I R T U A L _ S T O P S )  
 	 {  
 	 	 r e t u r n   0 ;  
 	 }  
 	  
 	 i f   ( i n i t i a l i z e d   = =   f a l s e   | |   c o m m a n d   = =   " i n i t i a l i z e " )  
 	 {  
 	 	 i n i t i a l i z e d   =   t r u e ;  
 	 }  
  
 	 / /   L i s t e n  
 	 i f   ( c o m m a n d   = =   " "   | |   c o m m a n d   = =   " l i s t e n " )  
 	 {  
 	 	 i n t   t o t a l           =   O b j e c t s T o t a l ( 0 ,   - 1 ,   O B J _ H L I N E ) ;  
 	 	 i n t   l e n g t h         =   0 ;  
 	 	 c o l o r   c l r           =   c l r N O N E ;  
 	 	 i n t   s l t p             =   0 ;  
 	 	 u l o n g   t i c k e t     =   0 ;  
 	 	 d o u b l e   l e v e l     =   0 ;  
 	 	 d o u b l e   a s k b i d   =   0 ;  
 	 	 i n t   p o l a r i t y     =   0 ;  
 	 	 s t r i n g   s y m b o l   =   " " ;  
  
 	 	 f o r   ( i   =   t o t a l   -   1 ;   i   > =   0 ;   i - - )  
 	 	 {  
 	 	 	 n a m e   =   O b j e c t N a m e ( 0 ,   i ,   - 1 ,   O B J _ H L I N E ) ;   / /   f o r   e x a m p l e :   # 1   s l  
  
 	 	 	 i f   ( S t r i n g S u b s t r ( n a m e ,   0 ,   1 )   ! =   " # " )  
 	 	 	 {  
 	 	 	 	 c o n t i n u e ;  
 	 	 	 }  
  
 	 	 	 l e n g t h   =   S t r i n g L e n ( n a m e ) ;  
  
 	 	 	 i f   ( l e n g t h   <   5 )  
 	 	 	 {  
 	 	 	 	 c o n t i n u e ;  
 	 	 	 }  
  
 	 	 	 c l r   =   ( c o l o r ) O b j e c t G e t I n t e g e r ( 0 ,   n a m e ,   O B J P R O P _ C O L O R ) ;  
  
 	 	 	 i f   ( c l r   ! =   l o o p _ c o l o r [ 0 ]   & &   c l r   ! =   l o o p _ c o l o r [ 1 ] )  
 	 	 	 {  
 	 	 	 	 c o n t i n u e ;  
 	 	 	 }  
  
 	 	 	 s t r i n g   l a s t _ s y m b o l s   =   S t r i n g S u b s t r ( n a m e ,   l e n g t h - 2 ,   2 ) ;  
  
 	 	 	 i f   ( l a s t _ s y m b o l s   = =   " s l " )  
 	 	 	 {  
 	 	 	 	 s l t p   =   - 1 ;  
 	 	 	 }  
 	 	 	 e l s e   i f   ( l a s t _ s y m b o l s   = =   " t p " )  
 	 	 	 {  
 	 	 	 	 s l t p   =   1 ;  
 	 	 	 }  
 	 	 	 e l s e  
 	 	 	 {  
 	 	 	 	 c o n t i n u e ; 	  
 	 	 	 }  
  
 	 	 	 u l o n g   t i c k e t 0   =   S t r i n g T o I n t e g e r ( S t r i n g S u b s t r ( n a m e ,   1 ,   l e n g t h   -   4 ) ) ;  
  
 	 	 	 / /   p r e v e n t   l o a d i n g   t h e   s a m e   t i c k e t   n u m b e r   t w i c e   i n   a   r o w  
 	 	 	 i f   ( t i c k e t 0   ! =   t i c k e t )  
 	 	 	 {  
 	 	 	 	 t i c k e t   =   t i c k e t 0 ;  
  
 	 	 	 	 i f   ( T r a d e S e l e c t B y T i c k e t ( t i c k e t ) )  
 	 	 	 	 {  
 	 	 	 	 	 s y m b o l           =   O r d e r S y m b o l ( ) ;  
 	 	 	 	 	 p o l a r i t y       =   ( O r d e r T y p e ( )   = =   0 )   ?   1   :   - 1 ;  
 	 	 	 	 	 a s k b i d       =   ( O r d e r T y p e ( )   = =   0 )   ?   S y m b o l I n f o D o u b l e ( s y m b o l ,   S Y M B O L _ B I D )   :   S y m b o l I n f o D o u b l e ( s y m b o l ,   S Y M B O L _ A S K ) ;  
 	 	 	 	 	  
 	 	 	 	 	 t r a d e _ p a s s   =   t r u e ;  
 	 	 	 	 }  
 	 	 	 	 e l s e  
 	 	 	 	 {  
 	 	 	 	 	 t r a d e _ p a s s   =   f a l s e ;  
 	 	 	 	 }  
 	 	 	 }  
  
 	 	 	 i f   ( t r a d e _ p a s s )  
 	 	 	 {  
 	 	 	 	 l e v e l         =   O b j e c t G e t D o u b l e ( 0 ,   n a m e ,   O B J P R O P _ P R I C E ,   0 ) ;  
  
 	 	 	 	 i f   ( l e v e l   >   0 )  
 	 	 	 	 {  
 	 	 	 	 	 / /   p o l a r i z e   l e v e l s  
 	 	 	 	 	 d o u b l e   l e v e l _ p     =   p o l a r i t y   *   l e v e l ;  
 	 	 	 	 	 d o u b l e   a s k b i d _ p   =   p o l a r i t y   *   a s k b i d ;  
  
 	 	 	 	 	 i f   (  
 	 	 	 	 	 	       ( s l t p   = =   - 1   & &   ( l e v e l _ p   -   a s k b i d _ p )   > =   0 )   / /   s l  
 	 	 	 	 	 	 | |   ( s l t p   = =   1   & &   ( a s k b i d _ p   -   l e v e l _ p )   > =   0 )     / /   t p  
 	 	 	 	 	 )  
 	 	 	 	 	 {  
 	 	 	 	 	 	 / / - -   V i r t u a l   S t o p s   S L   T i m e o u t  
 	 	 	 	 	 	 i f   (  
 	 	 	 	 	 	 	       ( V I R T U A L _ S T O P S _ T I M E O U T   >   0 )  
 	 	 	 	 	 	 	 & &   ( s l t p   = =   - 1   & &   ( l e v e l _ p   -   a s k b i d _ p )   > =   0 )   / /   s l  
 	 	 	 	 	 	 )  
 	 	 	 	 	 	 {  
 	 	 	 	 	 	 	 / /   s t a r t   t i m e o u t ?  
 	 	 	 	 	 	 	 i n t   i n d e x   =   A r r a y S e a r c h ( m e m _ t o _ t i ,   t i c k e t ) ;  
  
 	 	 	 	 	 	 	 i f   ( i n d e x   <   0 )  
 	 	 	 	 	 	 	 {  
 	 	 	 	 	 	 	 	 i n t   s i z e   =   A r r a y S i z e ( m e m _ t o _ t i ) ;  
 	 	 	 	 	 	 	 	 A r r a y R e s i z e ( m e m _ t o _ t i ,   s i z e + 1 ) ;  
 	 	 	 	 	 	 	 	 A r r a y R e s i z e ( m e m _ t o ,   s i z e + 1 ) ;  
 	 	 	 	 	 	 	 	 m e m _ t o _ t i [ s i z e ]   =   t i c k e t ;  
 	 	 	 	 	 	 	 	 m e m _ t o [ s i z e ]         =   ( i n t ) T i m e L o c a l ( ) ;  
  
 	 	 	 	 	 	 	 	 P r i n t (  
 	 	 	 	 	 	 	 	 	 " # " ,  
 	 	 	 	 	 	 	 	 	 t i c k e t ,  
 	 	 	 	 	 	 	 	 	 "   t i m e o u t   o f   " ,  
 	 	 	 	 	 	 	 	 	 V I R T U A L _ S T O P S _ T I M E O U T ,  
 	 	 	 	 	 	 	 	 	 "   s e c o n d s   s t a r t e d "  
 	 	 	 	 	 	 	 	 ) ;  
  
 	 	 	 	 	 	 	 	 r e t u r n   0 ;  
 	 	 	 	 	 	 	 }  
 	 	 	 	 	 	 	 e l s e  
 	 	 	 	 	 	 	 {  
 	 	 	 	 	 	 	 	 i f   ( T i m e L o c a l ( )   -   m e m _ t o [ i n d e x ]   < =   V I R T U A L _ S T O P S _ T I M E O U T )  
 	 	 	 	 	 	 	 	 {  
 	 	 	 	 	 	 	 	 	 r e t u r n   0 ;  
 	 	 	 	 	 	 	 	 }  
 	 	 	 	 	 	 	 }  
 	 	 	 	 	 	 }  
  
 	 	 	 	 	 	 i f   ( C l o s e T r a d e ( t i c k e t ) )  
 	 	 	 	 	 	 {  
 	 	 	 	 	 	 	 / /   c h e c k   t h i s   b e f o r e   d e l e t i n g   t h e   l i n e s  
 	 	 	 	 	 	 	 / / O n T r a d e L i s t e n e r ( ) ;  
  
 	 	 	 	 	 	 	 / /   d e l e t e   o b j e c t s  
 	 	 	 	 	 	 	 O b j e c t D e l e t e ( 0 ,   " # "   +   ( s t r i n g ) t i c k e t   +   "   s l " ) ;  
 	 	 	 	 	 	 	 O b j e c t D e l e t e ( 0 ,   " # "   +   ( s t r i n g ) t i c k e t   +   "   t p " ) ;  
 	 	 	 	 	 	 }  
 	 	 	 	 	 }  
 	 	 	 	 	 e l s e  
 	 	 	 	 	 {  
 	 	 	 	 	 	 i f   ( V I R T U A L _ S T O P S _ T I M E O U T   >   0 )  
 	 	 	 	 	 	 {  
 	 	 	 	 	 	 	 i   =   A r r a y S e a r c h ( m e m _ t o _ t i ,   t i c k e t ) ;  
  
 	 	 	 	 	 	 	 i f   ( i   > =   0 )  
 	 	 	 	 	 	 	 {  
 	 	 	 	 	 	 	 	 A r r a y S t r i p K e y ( m e m _ t o _ t i ,   i ) ;  
 	 	 	 	 	 	 	 	 A r r a y S t r i p K e y ( m e m _ t o ,   i ) ;  
 	 	 	 	 	 	 	 }  
 	 	 	 	 	 	 }  
 	 	 	 	 	 }  
 	 	 	 	 }  
 	 	 	 }  
 	 	 	 e l s e   i f   (  
 	 	 	 	 	 ! P e n d i n g O r d e r S e l e c t B y T i c k e t ( t i c k e t )  
 	 	 	 	 | |   O r d e r C l o s e T i m e ( )   >   0   / /   i n   c a s e   t h e   o r d e r   h a s   b e e n   c l o s e d  
 	 	 	 )  
 	 	 	 {  
 	 	 	 	 O b j e c t D e l e t e ( 0 ,   n a m e ) ;  
 	 	 	 }  
 	 	 	 e l s e  
 	 	 	 {  
 	 	 	 	 P e n d i n g O r d e r S e l e c t B y T i c k e t ( t i c k e t ) ;  
 	 	 	 }  
 	 	 }  
 	 }  
 	 / /   G e t   S L   o r   T P  
 	 e l s e   i f   (  
 	 	 t i   >   0  
 	 	 & &   (  
 	 	 	       c o m m a n d   = =   " g e t   s l "  
 	 	 	 | |   c o m m a n d   = =   " g e t   t p "  
 	 	 )  
 	 )  
 	 {  
 	 	 d o u b l e   v a l u e   =   0 ;  
  
 	 	 n a m e   =   " # "   +   I n t e g e r T o S t r i n g ( t i )   +   "   "   +   S t r i n g S u b s t r ( c o m m a n d ,   4 ,   2 ) ;  
  
 	 	 i f   ( O b j e c t F i n d ( 0 ,   n a m e )   >   - 1 )  
 	 	 {  
 	 	 	 v a l u e   =   O b j e c t G e t D o u b l e ( 0 ,   n a m e ,   O B J P R O P _ P R I C E ,   0 ) ;  
 	 	 }  
  
 	 	 r e t u r n   v a l u e ;  
 	 }  
 	 / /   S e t   S L   a n d   T P  
 	 e l s e   i f   (  
 	 	 t i   >   0  
 	 	 & &   (  
 	 	 	       c o m m a n d   = =   " s e t "  
 	 	 	 | |   c o m m a n d   = =   " m o d i f y "  
 	 	 	 | |   c o m m a n d   = =   " c l e a r "  
 	 	 	 | |   c o m m a n d   = =   " p a r t i a l "  
 	 	 )  
 	 )  
 	 {  
 	 	 l o o p _ p r i c e [ 0 ]   =   s l ;  
 	 	 l o o p _ p r i c e [ 1 ]   =   t p ;  
  
 	 	 f o r   ( i   =   0 ;   i   <   2 ;   i + + )  
 	 	 {  
 	 	 	 n a m e   =   " # "   +   I n t e g e r T o S t r i n g ( t i )   +   "   "   +   l o o p _ n a m e [ i ] ;  
 	 	 	  
 	 	 	 i f   ( l o o p _ p r i c e [ i ]   >   0 )  
 	 	 	 {  
 	 	 	 	 / /   1 )   c r e a t e   a   n e w   l i n e  
 	 	 	 	 i f   ( O b j e c t F i n d ( 0 ,   n a m e )   = =   - 1 )  
 	 	 	 	 {  
 	 	 	 	 	 	   O b j e c t C r e a t e ( 0 ,   n a m e ,   O B J _ H L I N E ,   0 ,   0 ,   l o o p _ p r i c e [ i ] ) ;  
 	 	 	 	 	 O b j e c t S e t I n t e g e r ( 0 ,   n a m e ,   O B J P R O P _ W I D T H ,   1 ) ;  
 	 	 	 	 	 O b j e c t S e t I n t e g e r ( 0 ,   n a m e ,   O B J P R O P _ C O L O R ,   l o o p _ c o l o r [ i ] ) ;  
 	 	 	 	 	 O b j e c t S e t I n t e g e r ( 0 ,   n a m e ,   O B J P R O P _ S T Y L E ,   S T Y L E _ D O T ) ;  
 	 	 	 	 	 O b j e c t S e t S t r i n g ( 0 ,   n a m e ,   O B J P R O P _ T E X T ,   n a m e   +   "   ( v i r t u a l ) " ) ;  
 	 	 	 	 }  
 	 	 	 	 / /   2 )   m o d i f y   e x i s t i n g   l i n e  
 	 	 	 	 e l s e  
 	 	 	 	 {  
 	 	 	 	 	 O b j e c t S e t D o u b l e ( 0 ,   n a m e ,   O B J P R O P _ P R I C E ,   0 ,   l o o p _ p r i c e [ i ] ) ;  
 	 	 	 	 }  
 	 	 	 }  
 	 	 	 e l s e  
 	 	 	 {  
 	 	 	 	 / /   3 )   d e l e t e   e x i s t i n g   l i n e  
 	 	 	 	 O b j e c t D e l e t e ( 0 ,   n a m e ) ;  
 	 	 	 }  
 	 	 }  
  
 	 	 / /   p r i n t   m e s s a g e  
 	 	 i f   ( c o m m a n d   = =   " s e t "   | |   c o m m a n d   = =   " m o d i f y " )  
 	 	 {  
 	 	 	 P r i n t (  
 	 	 	 	 c o m m a n d ,  
 	 	 	 	 "   # " ,  
 	 	 	 	 I n t e g e r T o S t r i n g ( t i ) ,  
 	 	 	 	 " :   v i r t u a l   s l   " ,  
 	 	 	 	 D o u b l e T o S t r ( s l ,   ( i n t ) S y m b o l I n f o I n t e g e r ( S y m b o l ( ) , S Y M B O L _ D I G I T S ) ) ,  
 	 	 	 	 "   t p   " ,  
 	 	 	 	 D o u b l e T o S t r ( t p , ( i n t ) S y m b o l I n f o I n t e g e r ( S y m b o l ( ) , S Y M B O L _ D I G I T S ) )  
 	 	 	 ) ;  
 	 	 }  
  
 	 	 r e t u r n   1 ;  
 	 }  
  
 	 r e t u r n   1 ;  
 }  
  
 v o i d   W a i t T r a d e C o n t e x t I f B u s y ( )  
 {  
 	 i f ( I s T r a d e C o n t e x t B u s y ( ) )   {  
             w h i l e ( t r u e )  
             {  
                   S l e e p ( 1 ) ;  
                   i f ( ! I s T r a d e C o n t e x t B u s y ( ) )   {  
                         R e f r e s h R a t e s ( ) ;  
                         b r e a k ;  
                   }  
             }  
       }  
       r e t u r n ;  
 }  
  
 d o u b l e   a t t r S t o p L o s s ( )  
 {  
 	 i f   ( U S E _ V I R T U A L _ S T O P S )  
 	 {  
 	 	 r e t u r n   V i r t u a l S t o p s D r i v e r ( " g e t   s l " ,   O r d e r T i c k e t ( ) ) ;  
 	 }  
  
 	 r e t u r n   O r d e r S t o p L o s s ( ) ;  
 }  
  
 d o u b l e   a t t r T a k e P r o f i t ( )  
 {  
 	 i f   ( U S E _ V I R T U A L _ S T O P S )  
 	 {  
 	 	 r e t u r n   V i r t u a l S t o p s D r i v e r ( " g e t   t p " ,   O r d e r T i c k e t ( ) ) ;  
 	 }  
  
       r e t u r n   O r d e r T a k e P r o f i t ( ) ;  
 }  
  
 s t r i n g   e _ R e a s o n ( b o o l   s e t = f a l s e ,   s t r i n g   i n p = " " )   {  
       s t a t i c   s t r i n g   m e m [ ] ;  
       i n t   q u e u e = O n T r a d e Q u e u e ( ) - 1 ;  
       i f ( s e t = = t r u e ) {  
             A r r a y R e s i z e ( m e m , q u e u e + 1 ) ;  
             m e m [ q u e u e ] = i n p ;  
       }  
       r e t u r n ( m e m [ q u e u e ] ) ;  
 }  
  
 s t r i n g   e _ R e a s o n D e t a i l ( b o o l   s e t = f a l s e ,   s t r i n g   i n p = " " )   { s t a t i c   s t r i n g   m e m [ ] ; i n t   q u e u e = O n T r a d e Q u e u e ( ) - 1 ; i f ( s e t = = t r u e ) { A r r a y R e s i z e ( m e m , q u e u e + 1 ) ; m e m [ q u e u e ] = i n p ; } r e t u r n ( m e m [ q u e u e ] ) ; }  
  
 d o u b l e   e _ a t t r C l o s e P r i c e ( b o o l   s e t = f a l s e ,   d o u b l e   i n p = - 1 )   { s t a t i c   d o u b l e   m e m [ ] ; i n t   q u e u e = O n T r a d e Q u e u e ( ) - 1 ; i f ( s e t = = t r u e ) { A r r a y R e s i z e ( m e m , q u e u e + 1 ) ; m e m [ q u e u e ] = i n p ; } r e t u r n ( m e m [ q u e u e ] ) ; }  
  
 d a t e t i m e   e _ a t t r C l o s e T i m e ( b o o l   s e t = f a l s e ,   d a t e t i m e   i n p = - 1 )   { s t a t i c   d a t e t i m e   m e m [ ] ; i n t   q u e u e = O n T r a d e Q u e u e ( ) - 1 ; i f ( s e t = = t r u e ) { A r r a y R e s i z e ( m e m , q u e u e + 1 ) ; m e m [ q u e u e ] = i n p ; } r e t u r n ( m e m [ q u e u e ] ) ; }  
  
 s t r i n g   e _ a t t r C o m m e n t ( b o o l   s e t = f a l s e ,   s t r i n g   i n p = " " )   { s t a t i c   s t r i n g   m e m [ ] ; i n t   q u e u e = O n T r a d e Q u e u e ( ) - 1 ; i f ( s e t = = t r u e ) { A r r a y R e s i z e ( m e m , q u e u e + 1 ) ; m e m [ q u e u e ] = i n p ; } r e t u r n ( m e m [ q u e u e ] ) ; }  
  
 d o u b l e   e _ a t t r C o m m i s s i o n ( b o o l   s e t = f a l s e ,   d o u b l e   i n p = 0 )   { s t a t i c   d o u b l e   m e m [ ] ; i n t   q u e u e = O n T r a d e Q u e u e ( ) - 1 ; i f ( s e t = = t r u e ) { A r r a y R e s i z e ( m e m , q u e u e + 1 ) ; m e m [ q u e u e ] = i n p ; } r e t u r n ( m e m [ q u e u e ] ) ; }  
  
 d a t e t i m e   e _ a t t r E x p i r a t i o n ( b o o l   s e t = f a l s e ,   d a t e t i m e   i n p = 0 )   { s t a t i c   d a t e t i m e   m e m [ ] ; i n t   q u e u e = O n T r a d e Q u e u e ( ) - 1 ; i f ( s e t = = t r u e ) { A r r a y R e s i z e ( m e m , q u e u e + 1 ) ; m e m [ q u e u e ] = i n p ; } r e t u r n ( m e m [ q u e u e ] ) ; }  
  
 d o u b l e   e _ a t t r L o t s ( b o o l   s e t = f a l s e ,   d o u b l e   i n p = - 1 )   { s t a t i c   d o u b l e   m e m [ ] ; i n t   q u e u e = O n T r a d e Q u e u e ( ) - 1 ; i f ( s e t = = t r u e ) { A r r a y R e s i z e ( m e m , q u e u e + 1 ) ; m e m [ q u e u e ] = i n p ; } r e t u r n ( m e m [ q u e u e ] ) ; }  
  
 i n t   e _ a t t r M a g i c N u m b e r ( b o o l   s e t = f a l s e ,   i n t   i n p = - 1 )   { s t a t i c   i n t   m e m [ ] ; i n t   q u e u e = O n T r a d e Q u e u e ( ) - 1 ; i f ( s e t = = t r u e ) { A r r a y R e s i z e ( m e m , q u e u e + 1 ) ; m e m [ q u e u e ] = i n p ; } r e t u r n ( m e m [ q u e u e ] ) ; }  
  
 d o u b l e   e _ a t t r O p e n P r i c e ( b o o l   s e t = f a l s e ,   d o u b l e   i n p = - 1 )   { s t a t i c   d o u b l e   m e m [ ] ; i n t   q u e u e = O n T r a d e Q u e u e ( ) - 1 ; i f ( s e t = = t r u e ) { A r r a y R e s i z e ( m e m , q u e u e + 1 ) ; m e m [ q u e u e ] = i n p ; } r e t u r n ( m e m [ q u e u e ] ) ; }  
  
 d a t e t i m e   e _ a t t r O p e n T i m e ( b o o l   s e t = f a l s e ,   d a t e t i m e   i n p = - 1 )   { s t a t i c   d a t e t i m e   m e m [ ] ; i n t   q u e u e = O n T r a d e Q u e u e ( ) - 1 ; i f ( s e t = = t r u e ) { A r r a y R e s i z e ( m e m , q u e u e + 1 ) ; m e m [ q u e u e ] = i n p ; } r e t u r n ( m e m [ q u e u e ] ) ; }  
  
 d o u b l e   e _ a t t r P r o f i t ( b o o l   s e t = f a l s e ,   d o u b l e   i n p = 0 )   { s t a t i c   d o u b l e   m e m [ ] ; i n t   q u e u e = O n T r a d e Q u e u e ( ) - 1 ; i f ( s e t = = t r u e ) { A r r a y R e s i z e ( m e m , q u e u e + 1 ) ; m e m [ q u e u e ] = i n p ; } r e t u r n ( m e m [ q u e u e ] ) ; }  
  
 d o u b l e   e _ a t t r S t o p L o s s ( b o o l   s e t = f a l s e ,   d o u b l e   i n p = - 1 )   { s t a t i c   d o u b l e   m e m [ ] ; i n t   q u e u e = O n T r a d e Q u e u e ( ) - 1 ; i f ( s e t = = t r u e ) { A r r a y R e s i z e ( m e m , q u e u e + 1 ) ; m e m [ q u e u e ] = i n p ; } r e t u r n ( m e m [ q u e u e ] ) ; }  
  
 d o u b l e   e _ a t t r S w a p ( b o o l   s e t = f a l s e ,   d o u b l e   i n p = 0 )   { s t a t i c   d o u b l e   m e m [ ] ; i n t   q u e u e = O n T r a d e Q u e u e ( ) - 1 ; i f ( s e t = = t r u e ) { A r r a y R e s i z e ( m e m , q u e u e + 1 ) ; m e m [ q u e u e ] = i n p ; } r e t u r n ( m e m [ q u e u e ] ) ; }  
  
 s t r i n g   e _ a t t r S y m b o l ( b o o l   s e t = f a l s e ,   s t r i n g   i n p = " " )   { s t a t i c   s t r i n g   m e m [ ] ; i n t   q u e u e = O n T r a d e Q u e u e ( ) - 1 ; i f ( s e t = = t r u e ) { A r r a y R e s i z e ( m e m , q u e u e + 1 ) ; m e m [ q u e u e ] = i n p ; } r e t u r n ( m e m [ q u e u e ] ) ; }  
  
 d o u b l e   e _ a t t r T a k e P r o f i t ( b o o l   s e t = f a l s e ,   d o u b l e   i n p = - 1 )   { s t a t i c   d o u b l e   m e m [ ] ; i n t   q u e u e = O n T r a d e Q u e u e ( ) - 1 ; i f ( s e t = = t r u e ) { A r r a y R e s i z e ( m e m , q u e u e + 1 ) ; m e m [ q u e u e ] = i n p ; } r e t u r n ( m e m [ q u e u e ] ) ; }  
  
 i n t   e _ a t t r T i c k e t ( b o o l   s e t = f a l s e ,   i n t   i n p = - 1 )   { s t a t i c   i n t   m e m [ ] ; i n t   q u e u e = O n T r a d e Q u e u e ( ) - 1 ; i f ( s e t = = t r u e ) { A r r a y R e s i z e ( m e m , q u e u e + 1 ) ; m e m [ q u e u e ] = i n p ; } r e t u r n ( m e m [ q u e u e ] ) ; }  
  
 i n t   e _ a t t r T y p e ( b o o l   s e t = f a l s e ,   i n t   i n p = - 1 )  
 {  
 	 s t a t i c   i n t   m e m [ ] ;  
 	 i n t   q u e u e   =   O n T r a d e Q u e u e ( ) - 1 ;  
  
 	 i f   ( s e t   = =   t r u e )  
 	 {  
 	 	 A r r a y R e s i z e ( m e m , q u e u e + 1 ) ;  
 	 	 m e m [ q u e u e ]   =   i n p ;  
 	 }  
 	  
 	 r e t u r n   m e m [ q u e u e ] ;  
 }  
  
 t e m p l a t e < t y p e n a m e   D T 1 ,   t y p e n a m e   D T 2 >  
 d o u b l e   f o r m u l a ( s t r i n g   s i g n ,   D T 1   v 1 ,   D T 2   v 2 )  
 {  
 	           i f   ( s i g n   = =   " + " )   r e t u r n ( v 1   +   v 2 ) ;  
 	 e l s e   i f   ( s i g n   = =   " - " )   r e t u r n ( v 1   -   v 2 ) ;  
 	 e l s e   i f   ( s i g n   = =   " * " )   r e t u r n ( v 1   *   v 2 ) ;  
 	 e l s e   i f   ( s i g n   = =   " / " )   r e t u r n ( v 1   /   v 2 ) ;  
  
 	 r e t u r n   f a l s e ;  
 }  
  
 s t r i n g   f o r m u l a ( s t r i n g   s i g n ,   s t r i n g   v 1 ,   s t r i n g   v 2 )  
 {  
 	 i f   ( s i g n   = =   " + " )   r e t u r n ( v 1   +   v 2 ) ;  
 	 e l s e   {  
 	 	 d o u b l e   _ v 1   =   S t r i n g T o D o u b l e ( v 1 ) ;  
 	 	 d o u b l e   _ v 2   =   S t r i n g T o D o u b l e ( v 2 ) ;  
 	 	  
 	 	           i f   ( s i g n   = =   " - " )   r e t u r n   D o u b l e T o S t r i n g ( _ v 1   -   _ v 2 ) ;  
 	 	 e l s e   i f   ( s i g n   = =   " * " )   r e t u r n   D o u b l e T o S t r i n g ( _ v 1   *   _ v 2 ) ;  
 	 	 e l s e   i f   ( s i g n   = =   " / " )   r e t u r n   D o u b l e T o S t r i n g ( _ v 1   /   _ v 2 ) ;  
 	 }  
  
 	 r e t u r n   v 1   +   v 2 ;  
 }  
  
 d o u b l e   f o r m u l a ( s t r i n g   s i g n ,   s t r i n g   v 1 ,   d o u b l e   v 2 )  
 {  
 	           i f   ( s i g n   = =   " + " )   r e t u r n   S t r i n g T o D o u b l e ( v 1 )   +   v 2 ;  
 	 e l s e   i f   ( s i g n   = =   " - " )   r e t u r n   S t r i n g T o D o u b l e ( v 1 )   -   v 2 ;  
 	 e l s e   i f   ( s i g n   = =   " * " )   r e t u r n   S t r i n g T o D o u b l e ( v 1 )   *   v 2 ;  
 	 e l s e   i f   ( s i g n   = =   " / " )   r e t u r n   S t r i n g T o D o u b l e ( v 1 )   /   v 2 ;  
  
 	 r e t u r n   S t r i n g T o D o u b l e ( v 1 )   +   v 2 ;  
 }  
  
 d o u b l e   f o r m u l a ( s t r i n g   s i g n ,   d o u b l e   v 1 ,   s t r i n g   v 2 )  
 {  
 	 i f   ( s i g n   = =   " + " )   r e t u r n   ( v 1   +   S t r i n g T o D o u b l e ( v 2 ) ) ;  
 	 e l s e   i f   ( s i g n   = =   " - " )   r e t u r n   v 1   -   S t r i n g T o D o u b l e ( v 2 ) ;  
 	 e l s e   i f   ( s i g n   = =   " * " )   r e t u r n   v 1   *   S t r i n g T o D o u b l e ( v 2 ) ;  
 	 e l s e   i f   ( s i g n   = =   " / " )   r e t u r n   v 1   /   S t r i n g T o D o u b l e ( v 2 ) ;  
  
 	 r e t u r n   v 1   +   S t r i n g T o D o u b l e ( v 2 ) ;  
 }  
  
 d o u b l e   t o D i g i t s ( d o u b l e   p i p s ,   s t r i n g   s y m b o l )  
 {  
 	 i f   ( s y m b o l   = =   " " )   s y m b o l   =   S y m b o l ( ) ;  
  
 	 i n t   d i g i t s       =   ( i n t ) S y m b o l I n f o I n t e g e r ( s y m b o l ,   S Y M B O L _ D I G I T S ) ;  
 	 d o u b l e   p o i n t   =   S y m b o l I n f o D o u b l e ( s y m b o l ,   S Y M B O L _ P O I N T ) ;  
  
 	 r e t u r n   N o r m a l i z e D o u b l e ( p i p s   *   P i p V a l u e ( s y m b o l )   *   p o i n t ,   d i g i t s ) ;  
 }  
  
 d o u b l e   t o P i p s ( d o u b l e   d i g i t s ,   s t r i n g   s y m b o l )  
 {  
 	 i f   ( s y m b o l   = =   " " )   s y m b o l   =   S y m b o l ( ) ;  
  
       r e t u r n   d i g i t s   /   ( P i p V a l u e ( s y m b o l )   *   S y m b o l I n f o D o u b l e ( s y m b o l ,   S Y M B O L _ P O I N T ) ) ;  
 }  
  
  
  
  
  
  
 c l a s s   F x d W a i t i n g  
 {  
 	 p r i v a t e :  
 	 	 i n t   b e g i n n i n g _ i d ;  
 	 	 u s h o r t   b a n k     [ ] [ 2 ] [ 2 0 ] ;   / /   2   b a n k s ,   2 0   p o s s i b l e   p a r a l l e l   w a i t i n g   b l o c k s   p e r   c h a i n   o f   b l o c k s  
 	 	 u s h o r t   s t a t e   [ ] [ 2 ] ;           / /   s e c o n d   d i m e n t i o n   v a l u e s :   0   -   c o u n t   o f   t h e   b l o c k s   p u t   o n   h o l d ,   1   -   c u r r e n t   b a n k   i d  
  
 	 p u b l i c :  
 	 	 v o i d   I n i t i a l i z e ( i n t   c o u n t )  
 	 	 {  
 	 	 	 A r r a y R e s i z e ( b a n k ,   c o u n t ) ;  
 	 	 	 A r r a y R e s i z e ( s t a t e ,   c o u n t ) ;  
 	 	 }  
  
 	 	 b o o l   R u n ( i n t   i d   =   0 )  
 	 	 {  
 	 	 	 b e g i n n i n g _ i d   =   i d ;  
  
 	 	 	 i n t   r a n g e   =   A r r a y R a n g e ( s t a t e ,   0 ) ;  
 	 	 	 i f   ( r a n g e   <   i d + 1 )   {  
 	 	 	 	 A r r a y R e s i z e ( b a n k ,   i d + 1 ) ;  
 	 	 	 	 A r r a y R e s i z e ( s t a t e ,   i d + 1 ) ;  
  
 	 	 	 	 / /   s e t   v a l u e s   t o   0 ,   o t h e r w i s e   t h e y   h a v e   r a n d o m   v a l u e s  
 	 	 	 	 f o r   ( i n t   i i   =   r a n g e ;   i i   <   i d + 1 ;   i i + + )  
 	 	 	 	 {  
 	 	 	 	       s t a t e [ i i ] [ 0 ]   =   0 ;  
 	 	 	 	       s t a t e [ i i ] [ 1 ]   =   0 ;  
 	 	 	 	 }  
 	 	 	 }  
  
 	 	 	 / /   a r e   t h e r e   b l o c k s   p u t   o n   h o l d ?  
 	 	 	 i n t   c o u n t   =   s t a t e [ i d ] [ 0 ] ;  
 	 	 	 i n t   b a n k _ i d   =   s t a t e [ i d ] [ 1 ] ;  
  
 	 	 	 / /   i f   n o   b l o c k   a r e   p u t   o n   h o l d   - >   e s c a p e  
 	 	 	 i f   ( c o u n t   = =   0 )   { r e t u r n   f a l s e ; }  
 	 	 	 e l s e  
 	 	 	 {  
 	 	 	 	 s t a t e [ i d ] [ 0 ]   =   0 ;   / /   n u l l   t h e   c o u n t  
 	 	 	 	 s t a t e [ i d ] [ 1 ]   =   ( b a n k _ i d )   ?   0   :   1 ;   / /   s w i t c h   t o   t h e   o t h e r   b a n k  
 	 	 	 }  
  
 	 	 	 / / = =   n o w   w e   w i l l   r u n   t h e   b l o c k s   p u t   o n   h o l d  
  
 	 	 	 f o r   ( i n t   i   =   0 ;   i   <   c o u n t ;   i + + )  
 	 	 	 {  
 	 	 	 	 i n t   b l o c k _ t o _ r u n   =   b a n k [ i d ] [ b a n k _ i d ] [ i ] ;  
 	 	 	 	 _ b l o c k s _ [ b l o c k _ t o _ r u n ] . r u n ( ) ;  
 	 	 	 }  
  
 	 	 	 r e t u r n   t r u e ;  
 	 	 }  
  
 	 	 v o i d   A c c u m u l a t e ( i n t   b l o c k _ i d   =   0 )  
 	 	 {  
 	 	 	 i n t   c o u n t       =   + + s t a t e [ b e g i n n i n g _ i d ] [ 0 ] ;  
 	 	 	 i n t   b a n k _ i d   =   s t a t e [ b e g i n n i n g _ i d ] [ 1 ] ;  
  
 	 	 	 b a n k [ b e g i n n i n g _ i d ] [ b a n k _ i d ] [ c o u n t - 1 ]   =   ( u s h o r t ) b l o c k _ i d ;  
 	 	 }  
 } ;  
 F x d W a i t i n g   f x d W a i t ;  
  
  
  
 / / + - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - +  
 / / |   E N D                                                                                                                             |  
 / / |   C r e a t e d   w i t h   f x D r e e m a   E A   B u i l d e r                       h t t p s : / / f x d r e e m a . c o m /   |  
 / / + - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - +  
  
 / * < f x d r e e m a : e N r t X e t T 2 0 g S / 1 c o 7 5 e 7 v S S n t 2 z n N l W E x y 5 V E D h M c n W f V L I 0 h l l k S S v J E F 8 q / / t 1 z 0 M v Z I M d 4 Y A t v m C r Z 3 p 6 u u f X 0 z 0 P 2 R 3 a w 2 / p s D / s p S T L a H i d 9 t 6 7 Q 6 2 P D 1 V t 2 I u T 6 E / i Z U 7 o T k n v P T y D k v p e l r g + 2 Z u 6 C d Z w A 0 5 R h z 3 f z Y j j J Q T + 9 d 7 T o a q b a n 9 g W 4 N B m T 6 N f D q Z c 7 p l m o Z q 2 5 a g T 9 1 r 6 j l p B o y R p T H s G b Y 9 k N z H Q e T d p l i f N z j s K e y / M u w R L 3 T G S X R L k t 7 7 8 V C B p x o 8 9 U m G s n O C 4 9 N r m q W S r t r D 3 n X i x j d O l F A S Z m 5 G o 1 C 2 d B X F V 9 H H K M u i K X t k D X u u l 9 E 7 6 F w E R W m I 7 T D 5 r q h 3 i x 8 1 q H V H U z o O i B P Q c e I m c + c 6 i W Y x E q F 6 O k 8 z w p n p w 1 5 G p y B Q S o C b n 6 I m L C Y S 6 D s K i R P T 2 E n p / 4 i o q r x T F E X t C Z l n K X H u a J L N 3 A A U F c U p a 3 3 Y C y N W Y s B L E O B / T U J v v q B M j e 4 k J K i o t K G I 6 / u V I v C B 3 I H i C o M Y 2 D G u D s a A U 7 2 5 B z q J S U I j n x k d y V A 0 p d N Z g O M B 6 6 R l 1 q j L K t W B o X Z L M q G Q o 8 + X n 0 e H s h m p d T Y 6 F u i c W 6 e k N A c t E M 0 y F E g R v Y k j G m Z O M g s I w 4 A + / I Y 0 A A N i A Q S e J H w 0 m N w k q l B q F o m + w 0 N 4 9 h 1 7 + L C S L e x Y q 1 Y y L 1 T U G i r 2 Z c U l N b 9 X s Z r N Y z l 2 y F d Q f C a H n Q e G c g I 3 v J 6 5 1 9 J i Z / 8 + N X K L h S 5 q M o 0 B w b 4 z B f Q k u c X 0 g g x Y m a W S o K F E B B Q N 4 / k m u n d o 6 F P P z a J E l P j O l Q s j P Q T Z A G N M u e B G h H Z 1 7 C + o d E J J 4 A t N H R 4 d 7 3 8 + v Z J m j G a J J x G v i o f g I q 7 5 g I C H d q 7 2 B 9 y g 6 M m n L 0 e X T 2 Q G n V G 1 3 B Y r y m Y 0 s u s z d n p b 7 A a M n b E i O 1 G z g Z / F + J l r 8 O s 3 8 t M Z P 2 s N f n q T a U 3 G z l 6 D n b W Y X X 9 1 Y 2 h N 3 D h q B y u P O 6 O J G T e E u g Y m z C X s 1 N X Z 2 U 3 s u F l V b Q 1 D a E v 4 r Q G L x m F i c H Z r w E J T m o a x J j y 5 u Z p t s a b W y E / 0 1 1 q d 3 x J Y q H Z L X g W F x l l k w B w 1 O P g w k 3 M g j 3 4 + O S z k S 3 E e h 7 g l Q 6 K B R K h M f R k j P S z F 5 i + I + l w 5 J 8 E 0 A r N s H i + S 1 E t o L E M v C N n E B H v n B r O S w b + z h k a n D 5 s V j 9 t o R 5 H t X F 0 0 t o O P 2 2 q H 6 / r O T S h O q U z X p p j 4 7 y m f I q v t 5 4 T 2 e g o G C 6 I 0 J Q 2 t l U j t t W c g 0 6 y 5 b 5 z w o C 2 Q w 4 9 m 4 1 K C 8 W h z R S D G g y I 2 I p 1 w N h 1 j M P N g 1 D 4 o 0 Y Y M e Z c x N W F P M a Z v 6 H m d 3 l L j J h 9 h 8 N S F S I 6 1 q w y / c Z P z J I o l e Q b G Y C x Y V U U O i N l N E g W M z F J A G K S / Y 0 R 9 J k J 8 E 5 M m E W G b g l a S A / s z m k / H U S A r s D A c H 4 g v o / y L r A L y f p z N 0 / N k R I I g F S Y c R 9 m N 8 G U H 0 T S G b o i u f Z B W u 0 i i C c 3 2 p 9 E s z C p 5 C d D O Q 4 9 c k O Q K D S s k n b h B S p h N u I 9 r T O J Q + T R F R P o y T b Q x h o b g N i x p s T C f C C G B J Y V E Z 5 a y f J F X 7 E t V 5 2 l L k Y 4 A D X O m w B G + B V R x c E O 8 2 1 M 3 z c 4 T n y S 8 c z L l g + 6 7 L B i H N q I o 8 d O S + o B v T C G 0 z g W G v q a e S M k t T P m S q R t I 2 6 Q E e f H g v D Q m Z E Q v s g 8 T 0 9 B o M p H J k c H H Z N 4 q H 1 o Z z X g r m i X E 3 4 u Z 2 H t / C 6 A f e x 5 4 E O L / X c g B 7 M S 0 I R O c g E x Y + m U q 3 K l A W s Y y B o i A u L O 4 d 1 E F v F d 1 Z 8 l F B 9 1 A D h f P s r T M m L K 8 b s y y E / h K x F f G F p O g t D q 1 j V 3 v F s d 0 6 L / 1 o i B K x L D 7 Z X 9 w M D g + F s M n p 4 D J f 5 H D d g L D 6 O 0 9 o d c 3 W V k 3 m N x K I D k w e B K 3 k B h H 5 z h C E 7 9 N s z n X H 6 8 n s r 8 m J J o / H 4 m t 4 0 Z r A T e o 6 E / R e U x g + D P Y p K 8 E M X 2 U m y + i P Q o P x E M Z H 4 a 5 o / D Q F 8 F D F 1 P q a Z R 3 s x h p q p x g 8 / m x V l v a 7 0 s + f 0 K n 1 b v h s B 4 W 4 G g 4 O L + 8 P D q 4 O j n / V E j G F e 1 V Z q l / i J D x s i W R x D y z U I S F a m W s c P X S / x N Q  
 V k V B Q t J Z w C c Z j B / q P W 4 d 8 n o L k I c 2 j g G f s 8 B 9 J V C v C r w S 0 j W t L a g r P w b 1 y a T f V 5 R 1 o L 4 E z s Y i O B s v D M 7 Q + G + / t Y t n D P h 0 b z h s y p e X y I U k L 4 G 8 7 J 7 6 P D w W a 1 D L n W q 7 K D Z a Q P E A o / r Q p / m W y 8 v H c V 3 k R 0 L a W k z 7 Q u b s 4 + P D g / 1 B S 0 D u Y + Z M 3 f A a v 4 o l 5 E Z A g 0 1 4 / P p F d F c V 8 g A q 5 Z q G J d C h t j V f K o 9 g q S S O D E V B n G L R Q w q k / Q S B 9 I V z c i G X / h P k M q q Q Z F y M z Q Q 4 F T n M B j n M j Q V a 7 b p T s 4 0 8 C L p w x j b V v x Q O 5 X m 9 q s m X j q T G M H k t P u u l z 0 Y + y t B D V F c f f 8 w j o 6 P j v d 6 r d H u p Z z Y G / V q M p b 6 M G M u E P 8 u q u 2 a k j N n f M y V V 1 s I 1 B 7 m t U F 9 Y a F w 5 g P 9 f o m A 2 J a X V i Q n 9 S v w q d S Q O N e A T 5 Z 3 K H C 5 f 9 0 X 5 i z K X N L 0 V E Z e p V F l I E q h W e 2 f K j W 1 O u y C J R / h q I D x T e c i K B 1 Y 4 + S P C q V R G p i R s W b U s Y A u O R G c d f C y e A y 7 H q K V L P H z y O a S Z V F C + i M 3 B X R Q 6 J A F H R L 5 z h f T p 9 O z 6 B K p T N z g V C i 0 J 0 O c F z i D Z o 3 E w P w 9 P o z Q t L 8 N g O F o t U V p / l B 7 R 5 m X 2 f R + b q D D J j 4 x U C l R 4 V E S 9 J I D O B g 5 2 h b x I B l X X r M W d 1 W W R S 3 I H X q + 2 / C t 5 H N N x t J A H n m i Y T g / B E e K k m z 2 i 2 L z c g g Y 1 J t G p O 4 5 m 3 g 1 J y G J 2 V r X g K U 3 z X R b 1 j f Z G f 2 O 8 M d 9 Y h a 6 L o o v 6 y p o e k b 8 + u i l p a F A V 5 M I U U F u H p q x K 7 U Z T a I K 4 q G l L o u 5 z D M n N K Z 3 S 8 u o D V h + B C 8 Z 2 G 1 1 G i X 4 h d k Z s d A a Q N P H t P h y z e Q m O 6 Y u E e g V 6 T F O a u 1 a M b + O V H A Q e F A t k o U 2 F M 6 z V u N V W q 1 1 a 1 q 7 f a r t l Z 7 W k Y Y y T 3 F v C x 1 K j 0 S s l 6 m b n Z k N s l s o s M f y g o S A f O i U 9 a W j 6 o t j G j I / t x i 2 3 + z T z Y 8 t + y y 0 / b Q C A I Y + + 5 t s X I O 3 v V w f C w P D 8 0 J 2 X Y 9 M + e / h H N E v S u k 6 R C Q 1 n G S m X x 1 g R C A 3 d y X d Y 8 c R f U 2 9 k 9 I O S X Y k y 5 b w I n 4 3 K J y g U E b I z Q u Z O 5 R a M o g y L Y Y X E A z f 0 A 3 J y W O 8 B 0 s 7 y A 4 3 S J Q 7 K l f D T J H F r 0 t i i S D S N o x D G 8 3 + J m 5 R Z 9 G v 0 M + j n T b m A V S s A W i + T 6 / x R / 5 V T P L m Q e Q v M E v U 4 o F J k x E 6 5 V o r o h b Z H N 3 S S l Y M R 5 g U k A T t Y N j N G E D m R 9 a 5 C L V f 9 D y G 3 F a J e I s r R l l u l X D M f d T W t 8 U Y f D L 0 K e S S P 9 D 4 k 3 9 I Y Z f J F 0 3 h Y N k H 8 I D b A c K O A x r E 4 l l l a Z j u b g y K n I m I t d W U / S a L 7 A 8 w T P s 7 m A k Z e k H x k k G w 9 S 7 V a y F I t t r v 4 K b r f Z G 6 q / J z c 1 G Z 9 3 Q t 5 Z 5 d m p J p V W / U 3 l O f J S N U V M 1 J F 6 S s P V / 3 5 f g D + L c h I 2 Z Y x H k R b I y s d 4 K a U l x V r i v a G 9 v z 6 f I 9 A r k Z u 8 V Z f e d m 1 d T d h d z t 8 y / c F z O q 2 g K V s 8 Q Z f f 0 M b f O t i 9 x n 2 9 f I Y 5 k X t 4 a m i W 7 y T K r 9 4 U R b 8 e w 3 G / W 6 L 7 / G F 5 N q x N V 1 R d m C P T 9 U 2 d Q h H 4 a g u N u S 2 e E 6 u 7 j 2 2 O y v n q V s 3 L S 8 + e F M L w b d 7 X l b X O k i H N y h d z 8 P T 1 s 4 + / 3 / 0 1 4 x m 8 w Y A M d 6 r 4 P W f 7 e L V Y i t h y i O L Y a 0 E 0 n z / a q M T d H 5 V r k P 0 Q k T r d r 9 2 A G e w z Y g 2 N p s m 5 5 u 2 K 0 D 8 1 9 e Y J r e C 7 o Y J 2 e j g u 1 p w b W 7 1 h G x 2 8 H 1 V 8 D U 7 + C 5 f 5 j J 2 C r 7 W L s J X 2 9 r Y 2 u r Q v R T d l q X W Y u t t v q a i 2 p u 6 p 7 L + i l e 3 k r 0 Q z H a 3 l P 2 E X a m d X M r e w f 2 p V 3 v v L H / d V A f l 5 e t e / d p K 9 m 5 A e b C T c / S r R v O g Q / P j k b Z d O y + i 7 M I 9 U k 1 5 d e 9 B w T s d q w O B d b V 7 C c q T X o I y 0 C t I M H f 1 J S i a + l M u 7 J V P + H c 3 9 b q b e t 1 N v e 6 m X n d T r 7 u p 1 9 3 U 6 2 7 q d T f 1 u p t 6 3 U 2 9 V m / q r Z d P 5 i 8 u 7 6 7 q P c 9 V P b V v V 9 d j t O 6 q X r F s o 3 X 7 K a 9 p B V b T u h X Y x 7 d G t V 3 c T 9 H 0 b j / l t a F Z 7 9 C 8 O p r N  
 n U D z e m / a x d 7 l P + X l 0 L P 9 B g j 1 Z U K 2 L 3 / e r X i n o Y 2 P 0 1 L O o A g G Z / s w n m 5 4 Y f x 6 f n j k j D h 7 7 M 5 + H A e U + P l K A f b + 4 v L k 4 M g 5 O D 0 f H S 1 a 0 Y Z n F 4 U M I P z F 0 e X J + a F z 8 B l A + + l K 6 D b P Y U r r 4 E 8 9 Q / l h m b f 5 A W 1 p D 7 W F W d w r U 9 f L 8 I L d y 4 m f 8 n L i 2 m m v n d h U N j f t B N W t d I L / e i Y n u B V T x s v w g W b n A 1 d 9 E Y t u 7 o Q P X O + i S h c I 1 n z g 2 2 f y g V s w Y / z o 7 9 D o 7 O J P + R f x 2 v e P 3 f 2 e x 8 5 a G b U A U d / i + z 3 a x u 7 3 G H y t q / p z j 6 u s d 3 1 o / 4 6 P 2 S w D G O V X V X k 9 1 3 y 0 7 p p P + A R c a 7 W g R 9 / 6 o I e L j u e e m I Z w T / H 7 / w H q L g X Q  
 : f x d r e e m a > * / 