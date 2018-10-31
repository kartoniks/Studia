const math = require('mathjs')

solve = function solve(spheres){
    if(spheres.length > 3){
        return solvemany(spheres);
    }
    if(spheres.length == 3) {
        return solvethree(spheres);
    }
}
function solvethree(spheres) {//solution: https://en.wikipedia.org/wiki/Trilateration
    var A_array = [];
    var b_vec = [];
    if(math.abs(spheres[0].point.z - spheres[1].point.z) < 0.1) {   //QR decomposition works when matrix is linearly independent
        spheres[0].point.z -= 0.2;  //avoids error of same-floor beacons
        spheres[1].point.z += 0.2;
    }
    for(i in spheres) {//linear variable factors stored in A_array
        let row = [spheres[i].point.x, spheres[i].point.y, spheres[i].point.z];
        let bi = spheres[i].distance * spheres[i].distance - spheres[i].point.x * spheres[i].point.x
                    -spheres[i].point.y * spheres[i].point.y - spheres[i].point.z * spheres[i].point.z;
        A_array.push(row);
        b_vec.push(bi);
    }

    var offset = A_array[0];
    for(i in spheres) {//position of first point should be 0,0,0 
        A_array[i][0] -= offset[0];
        A_array[i][1] -= offset[1];
        A_array[i][2] -= offset[2];
    }
    
    var cos_a = math.dot(A_array[1], [1, 0, 0])/math.norm(A_array[1], 2);
    var sin_a = math.norm(math.cross(A_array[1], [1, 0, 0]), 2)/math.norm(A_array[1], 2);
    //wiki: Rotation matrix from axis and angle
    var u = math.cross(A_array[1], [1,0,0]);
    var u_norm = math.norm(u, 2)
    u[0] /= u_norm;
    u[1] /= u_norm;
    u[2] /= u_norm;
    var rotation_1 = [  [cos_a+u[0]*u[0]*(1-cos_a), u[0]*u[1]*(1-cos_a)-u[2]*sin_a, u[0]*u[2]*(1-cos_a)+u[2]*sin_a],
                        [u[1]*u[0]*(1-cos_a)+u[2]*sin_a, cos_a+u[1]*u[1]*(1-cos_a), u[1]*u[2]*(1-cos_a)-u[0]*sin_a],
                        [u[2]*u[0]*(1-cos_a)-u[1]*sin_a, u[2]*u[1]*(1-cos_a)+u[0]*sin_a, cos_a+u[2]*u[2]*(1-cos_a)]];

    for(i in spheres) {//rotate to make y2=0
        A_array[i] = math.multiply(rotation_1, A_array[i]);
    }
    

    return math.lusolve(A_array, b_vec);
}
function solvemany(spheres) {
    var A_array = [];
    var b_vec = [];
    if(math.abs(spheres[0].point.z - spheres[1].point.z) < 0.1) {   //QR decomposition works when matrix is linearly independent
        spheres[0].point.z -= 0.2;  //avoids error of same-floor beacons
        spheres[1].point.z += 0.2;
    }
    for(i in spheres) {//linear variable factors stored in A_array
        let row = [1, -2*spheres[i].point.x, -2*spheres[i].point.y, -2*spheres[i].point.z];
        let bi = spheres[i].distance * spheres[i].distance - spheres[i].point.x * spheres[i].point.x
                    -spheres[i].point.y * spheres[i].point.y - spheres[i].point.z * spheres[i].point.z;
        A_array.push(row);
        b_vec.push(bi);
    }
    var res;
    if(spheres.length == 4) {
        res = math.lusolve(A_array, b_vec);
    }
    else {
        //calculate Ax=b, using A=QR, solve with Rx=QTb, because Q orthogonal so QT=Q^-1
        var QR = math.qr(A_array);
        var R = QR.R;
        R = [R[0], R[1], R[2], R[3]];
        var QT = math.transpose(QR.Q);
        QT = [QT[0], QT[1], QT[2], QT[3]];
        res = math.multiply(QT, b_vec);
        res = math.usolve(R, res);
    }
    var point = { x: math.round(res[1][0]),
                  y: math.round(res[2][0]),
                  z: math.round(res[3][0])};
    return point;
}

spheres = [];
spheres.push({ 
    point: {x: 0, y: 0, z: 0},
    distance: 25
   });
spheres.push({ 
    point: {x: 1, y: 1, z: 1},
    distance: 25
});
spheres.push({ 
    point: {x: 2, y: 2, z: 6},
    distance: 25
});
// spheres.push({ 
//     point: {x: 10, y: 70, z: 80},
//     distance: 25
//    });
// spheres.push({ 
//     point: {x: 20, y: 70, z: 80},
//     distance: 18.03
// });
// spheres.push({
//     point: {x: 30, y: 40, z: 80},
//     distance: 15
//  });
// spheres.push({
//     point: {x: 40, y: 40, z: 80},
//     distance: 18.03
// });
// spheres.push({
//     point: {x: 50, y: 70, z: 80},
//     distance: 25
// });

console.log(solve(spheres) );