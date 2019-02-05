professeur(turing, csi2520).
professeur(codd, csi4533).
professeur(backus, csi2511).
professeur(ritchie, csi2772).
professeur(minsky, csi2510).
professeur(codd, csi2530). 

etudiant(fred, csi2520).
etudiant(paul, csi4533).
etudiant(jean, csi2510).
etudiant(jean, csi2772).
etudiant(henri, csi2510).
etudiant(henri, csi2530). 

annee(fred, 1). 
annee(paul, 2). 
annee(jean, 2).
annee(henri, 4). 

meme(X1,X2) :- professeur(X,C), etudiant(X1,C),etudiant(X2,C).