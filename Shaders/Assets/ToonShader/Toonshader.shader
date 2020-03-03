Shader "Custom/Toonshader"
{
    Properties
    {
        _Color ("Color", Color) = (1,1,1,1)
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
        _Ramp ("Light Ramp",2D) = ""{}
        [HDR]_Emission("Emission",color) = (0,0,0,1)


    }
        SubShader
        {
            Tags { "RenderType" = "Opaque" }
            LOD 200

            CGPROGRAM
            // Physically based Standard lighting model, and enable shadows on all light types
            #pragma surface surf Custom fullforwardshadows

            // Use shader model 3.0 target, to get nicer looking lighting
            #pragma target 3.0

            sampler2D _Ramp;
            half4 LightingCustom(SurfaceOutput s, float3 lightDir, float atten) {
            float light = dot(s.Normal, lightDir);
            light = light * .5 + .5;
            float3 lightIntensity = tex2D(_Ramp, light).rgb;

            float4 col;

            col.rgb = lightIntensity * s.Albedo * atten *_LightColor0.rgb;

            col.a = s.Alpha;

            return col;
        }
        sampler2D _MainTex;

        struct Input
        {
            float2 uv_MainTex;
        };


        fixed4 _Color;
        half3 _Emission;
        // Add instancing support for this shader. You need to check 'Enable Instancing' on materials that use the shader.
        // See https://docs.unity3d.com/Manual/GPUInstancing.html for more information about instancing.
        // #pragma instancing_options assumeuniformscaling
        UNITY_INSTANCING_BUFFER_START(Props)
            // put more per-instance properties here
        UNITY_INSTANCING_BUFFER_END(Props)

        void surf (Input IN, inout SurfaceOutput o)
        {
            // Albedo comes from a texture tinted by color
            fixed4 c = tex2D (_MainTex, IN.uv_MainTex) * _Color;
            o.Albedo = c.rgb;
            o.Emission = _Emission;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
