#lang scheme "devoir4_q3"

;;Fonction de calcul de distance;;

;;Fonction principale qui calcule la distance en radian 
(define (distanceP pool1 pool2)
  (let (
        [lat1 (angleRad (cadr pool1))] ;;Ici on fait appel a la fonction pour convertir le input 
        [lon1 (angleRad (caddr pool1))]
        [lat2 (angleRad (cadr pool2))]
        [lon2 (angleRad (caddr pool2))])
    (* 2 6371.0 (asin (sqrt (+ (op1 lat1 lat2) (* (cos lat1) (cos lat2) (op1 lon1 lon2))))))))
;;Fonction ajoutee pour reduire le calcul (c'est devenu messy et dur a suivre ) 
(define (op1 value1 value2)
  (expt (sin (/ (- value1 value2) 2)) 2))
;;Definir la constante pi 
(define pi 3.14159265359)
;;Fonction de conversion deg -> rad 
(define (angleRad angDeg)(* pi (/ angDeg 180)))

;;Trier les emplacements à visiter d’ouest en est.

(define (poolTriee nomFichier)

  (sort

   (call-with-input-file nomFichier

     (lambda (input-port)

       (let loop ([line (read-line input-port)])

         (if (not (eof-object? line))

             (let ([splitline (string-split line ",")])

               (cons

                (list (car splitline) (string->number (list-ref splitline 1)) (string->number (list-ref splitline 2)))

                (loop (read-line input-port))))

             '()))))

   (lambda (x y) (< (cadr x) (cadr y)))))




;;L’emplacement le plus à l’ouest sera à la racine de l’arbre

(define (makeTree l)

  (let loop ([a (list (car l))]

             [c (cadr l)]

             [r (cddr l)]

             [arbre (list (car l))])

    (if (null? r)

        (ajoutNode (chercheProche c a) c arbre)

        (loop (cons c a) (car r) (cdr r) (ajoutNode (chercheProche c a) c arbre)))))        

(define (ajoutNode parent node tr)

  (let traverse ([t tr])

    (cond

      [(null? t) '()]

      [(and (string? (caar t)) (string=? (caar t) (car parent))) (cons (car t) (append (cdr t) (list (list node))))]

      [(string? (caar t)) (cons (car t) (traverse (cdr t)))]

      [else (cons (traverse (car t)) (traverse (cdr t)))])))

;;Chaque emplacement est ajouté à l’arbre comme enfant du nœud géographiquement le plus proche

(define (chercheProche pool liste_pool)

  (car (sort liste_pool (lambda (x y) (< (distanceP x pool) (distanceP y pool))))))


;;Parcourir l’arbre résultant de facon pré-ordre
(define (parcourArbre t)

  (let traverse ([t t])

    (cond

      [(null? t) '()]

      [(string? (caar t)) (cons (car t) (traverse (cdr t)))]

      [else (append (traverse (car t)) (traverse (cdr t)))])))

(define (parcourChemin l)

  (let traverse ([r (cdr l)]

                 [c (car l)]

                 [p (car l)]

                 [total 0])

    (let ([total (+ total (distanceP c p))])

      (if (null? r)

          (cons (list (car c) total) '())

          (cons (list (car c) total) (traverse (cdr r) (car r) c total))))))

(define (findRoute file)

  (parcourChemin (parcourArbre (makeTree (poolTriee file)))))


;;To review



(define (saveRoute solution file)

  (let ([outfile (open-output-file file #:exists 'append)])

    (let printrow ([solution solution])

      (unless (null? solution)

        (display (string-join (map (car solution)) " ") outfile)

        (display "\n" outfile)

        (printrow (cdr solution))))))

                                   

(findRoute "input.txt")

(saveRoute (findRoute "input.txt") "solution.txt")



