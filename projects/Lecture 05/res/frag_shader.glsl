#version 410

layout(location = 1) in vec3 inColor;
//Lec5
layout(location = 0) in vec3 inPos;
layout(location = 2) in vec3 inNormal;

uniform vec3 lightPos;
uniform vec3 cameraPos;

out vec4 frag_color;

void main() { 
	
	//lec 5 -- Ambient component
	vec3 lightColor = vec3(1.0, 1.0, 1.0);
	float ambientStrength = 0.1;
	vec3 ambient = ambientStrength* lightColor * inColor;

	//diffuse
	vec3 N = normalize(inNormal);
	vec3 lightDir = normalize(lightPos - inPos);

	float d = max(dot(N, lightDir), 0.0); // no negative diffuse
	vec3 diffuse = d*inColor;

	//Attenuation 
	float dist = length(lightPos - inPos);
	diffuse = diffuse/ dist* dist;


	// Specular
	float specularStrength = 1.0;
	vec3 camDir = normalize(cameraPos - inPos);
	vec3 reflectedRay = reflect(-lightDir, N);
	float spec = pow(max(dot(camDir, reflectedRay), 0.0), 8); // shinnyness coefficient 
	vec3 specular = specularStrength * spec * lightColor;


	vec3 result = ambient + diffuse + specular;
	frag_color = vec4(result, 1.0);
}