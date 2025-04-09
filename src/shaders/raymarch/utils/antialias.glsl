 const float AA_SIZE = 2.0;  // 2x2 samples

vec3 antialiasing( in vec3 col, in vec2 uv, in Camera ray ) {
    float count = 0.0;
    
    for(float aaY = 0.0; aaY < AA_SIZE; aaY++) {
        for(float aaX = 0.0; aaX < AA_SIZE; aaX++) {
            vec2 offset = vec2(aaX, aaY) / AA_SIZE;
            col += render(uv + offset, ray);
            count += 1.0;
        }
    }
}
    