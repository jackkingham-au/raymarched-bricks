/** Rotate a an object by a given angle. */
mat2 rotate(float radians) {
    float sin = sin(radians);
    float cos = cos(radians);
    return mat2(cos, -sin, sin, cos);
}