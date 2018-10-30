Averaging Quaternions
=====================

Since quaternions are not regular vectors, but rather representations of orientation, an average quaternion cannot just be obtained by taking a Euclidean weighted mean. This function implements the work done by F. Landis Merkley to calculate the average quaternion. The algorithm is explained at: 
http://www.acsu.buffalo.edu/~johnc/ave_quat07.pdf 
For this particular implementation, I would also like to reference Mandar Harshe: 
http://www-sop.inria.fr/members/Mandar.Harshe/knee-joint/html/index.html 
While being basic and straightforward, this algorithm is compared with rotqrmean from VoiceBox and found to produce quite similar results, yet it is more elegant, much simpler to implement and follow. (Though, there might be difference in signs)

The weighted averaging variant is similar but can incorporate a weight-per-quaternion. 

Enjoy!
