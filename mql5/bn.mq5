 if(!(Lower100000<Bid<Upper100000))
     {
      for(int i=0; i<m_Triangular100000.Total(); i++)
        {
         if(m_Triangular100000.At(i-1)<Bid>m_Triangular100000.At(i))
           {
            Lower100000=m_Triangular100000.At(i-1);
            Upper100000=m_Triangular100000.At(i);
           }
        }
     }